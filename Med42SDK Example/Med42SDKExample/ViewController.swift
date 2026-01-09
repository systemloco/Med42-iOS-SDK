//
//  ViewController.swift
//  Med42SDKExample
//
//  This file is a deliberately simple example of how to use the Med42 SDK.
//  It is designed to be easy to read, easy to copy, and hard to misuse.
//
//  What this screen does:
//  1. Requests background permissions
//  2. Starts and stops foreground scanning
//  3. Displays detected tags in a table
//  4. Uploads detected tags on demand
//
//  This is NOT production-ready code.
//

import UIKit
import Med42SDK

@available(iOS 14.0, *)
final class ViewController: UIViewController {

    // MARK: - State

    /// All tags detected by the SDK.
    /// This list is updated live via the Med42 delegate callbacks.
    private var detectedTags: [Med42Tag] = []

    /// Tracks whether scanning is currently active.
    /// Used only to toggle button state and labels.
    private var isScanning = false

    // MARK: - UI

    /// Vertical stack for buttons and status label
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let scanButton = UIButton.create(
        title: "Start Scanning",
        font: .systemFont(ofSize: 18, weight: .semibold),
        backgroundColor: .systemBlue
    )

    private let permissionsButton = UIButton.create(
        title: "Request Background Permissions",
        font: .systemFont(ofSize: 16),
        backgroundColor: .systemGreen
    )

    private let uploadButton = UIButton.create(
        title: "Upload Tags",
        font: .systemFont(ofSize: 16),
        backgroundColor: .systemOrange
    )

    private let printDeviceListButton = UIButton.create(
        title: "Print cached device list",
        font: .systemFont(ofSize: 14),
        backgroundColor: .systemCyan
    )

    /// Displays the current status of the SDK / app
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Status: Ready"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    /// Header label above the table view
    private let tagsLabel: UILabel = {
        let label = UILabel()
        label.text = "Detected Tags (0)"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    /// Displays detected tags
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "TagCell")
        return table
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        buildUI()
        wireUpButtons()
        connectSDKCallbacks()
    }

    // MARK: - Screen setup (UI layout)

    private func buildUI() {
        view.backgroundColor = .systemBackground
        title = "Med42 SDK Demo"
        
        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(stackView)
        view.addSubview(tagsLabel)
        view.addSubview(tableView)

        stackView.addArrangedSubview(scanButton)
        stackView.addArrangedSubview(permissionsButton)
        stackView.addArrangedSubview(uploadButton)
        stackView.addArrangedSubview(printDeviceListButton)
        stackView.addArrangedSubview(statusLabel)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            scanButton.heightAnchor.constraint(equalToConstant: 50),
            permissionsButton.heightAnchor.constraint(equalToConstant: 44),
            uploadButton.heightAnchor.constraint(equalToConstant: 44),
            printDeviceListButton.heightAnchor.constraint(equalToConstant: 44),

            tagsLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            tagsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tagsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            tableView.topAnchor.constraint(equalTo: tagsLabel.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    // MARK: - Wiring (buttons + SDK delegates)

    private func wireUpButtons() {
        scanButton.addTarget(self, action: #selector(scanButtonTapped), for: .touchUpInside)
        permissionsButton.addTarget(self, action: #selector(permissionsButtonTapped), for: .touchUpInside)
        uploadButton.addTarget(self, action: #selector(uploadButtonTapped), for: .touchUpInside)
        printDeviceListButton.addTarget(self, action: #selector(printDeviceListButtonTapped), for: .touchUpInside)
    }

    private func connectSDKCallbacks() {
        // Safe to call once (usually in viewDidLoad)
        Med42.shared.delegate = self
        Med42.shared.uploadDelegate = self
    }

    // MARK: - Button actions (user intent)

    @objc private func scanButtonTapped() {
        isScanning ? stopScanning() : startScanning()
    }

    @objc private func permissionsButtonTapped() {
        statusLabel.text = "Status: Requesting background permissions..."
        Med42.shared.requestBackgroundPermissions()

        // Fake delay just to show UI feedback
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.statusLabel.text = "Status: Permission request sent"
        }
    }

    @objc private func uploadButtonTapped() {
        uploadTags()
    }

    @objc private func printDeviceListButtonTapped() {
        print(Med42.shared.getDeviceListDebugInfo())
    }

    // MARK: - Med42 SDK helpers (the only place we talk to the SDK)

    private func startScanning() {
        let success = Med42.shared.startForegroundScanning()

        if success {
            isScanning = true
            scanButton.setTitle("Stop Scanning", for: .normal)
            scanButton.backgroundColor = .systemRed
            statusLabel.text = "Status: Scanning..."

            detectedTags.removeAll()
            updateTagUI()
        } else {
            statusLabel.text = "Status: Failed to start scanning"
        }
    }

    private func stopScanning() {
        let success = Med42.shared.stopScanning()

        if success {
            isScanning = false
            scanButton.setTitle("Start Scanning", for: .normal)
            scanButton.backgroundColor = .systemBlue
            statusLabel.text = "Status: Stopped"
        }
    }

    private func uploadTags() {
        uploadButton.isEnabled = false
        Med42.shared.uploadTags()
    }

    // MARK: - UI updates

    private func updateTagUI() {
        tagsLabel.text = "Detected Tags (\(detectedTags.count))"
        tableView.reloadData()
    }
}

// MARK: - Med42TagScannerDelegate (scan results)

@available(iOS 14.0, *)
extension ViewController: Med42TagScannerDelegate {

    func didDetectTag(_ tag: Med42Tag) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }

            // The SDK may report the same tag multiple times,
            // so we either update the existing entry or add a new one.
            if let index = detectedTags.firstIndex(where: { $0.deviceId == tag.deviceId }) {
                detectedTags[index] = tag
            } else {
                detectedTags.append(tag)
            }

            updateTagUI()
        }
    }

    func didFailWithError(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.statusLabel.text = "Status: Error - \(error.localizedDescription)"
        }
    }
}

// MARK: - Med42UploadDelegate (upload lifecycle)

@available(iOS 14.0, *)
extension ViewController: Med42UploadDelegate {

    func uploadDidStart() {
        DispatchQueue.main.async { [weak self] in
            self?.statusLabel.text = "Status: Uploading tags..."
            self?.uploadButton.setTitle("Uploading...", for: .normal)
        }
    }

    func uploadDidComplete() {
        DispatchQueue.main.async { [weak self] in
            self?.statusLabel.text = "Status: Upload successful"
            self?.uploadButton.setTitle("Upload Tags", for: .normal)
            self?.uploadButton.isEnabled = true
        }
    }

    func uploadDidFail(error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.statusLabel.text = "Status: Upload failed - \(error.localizedDescription)"
            self?.uploadButton.setTitle("Upload Tags", for: .normal)
            self?.uploadButton.isEnabled = true
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

@available(iOS 14.0, *)
extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        detectedTags.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell", for: indexPath)
        let tag = detectedTags[indexPath.row]

        // Intentionally verbose and boring for clarity
        let countText = tag.count != nil ? "\(tag.count!)" : "waiting"
        let batteryText = tag.battery != nil ? "\(tag.battery!)" : "waiting"
        let uptimeText = tag.uptime != nil ? "\(tag.uptime!)" : "waiting"

        var content = cell.defaultContentConfiguration()
        content.text = "ID: \(tag.deviceId)"
        content.secondaryText =
            "Cycle count: \(countText) | Battery: \(batteryText) | RSSI: \(tag.rssi) | Uptime: \(uptimeText)"
        content.secondaryTextProperties.font = .systemFont(ofSize: 12)
        content.secondaryTextProperties.color = .secondaryLabel

        cell.contentConfiguration = content
        return cell
    }
}
