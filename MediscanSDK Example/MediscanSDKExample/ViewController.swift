//
//  ViewController.swift
//  MediscanSDKExample
//
//  Created by Mark Johnson on 24/07/2025.
//

import UIKit
import MediscanSDK

@available(iOS 14.0, *)
class ViewController: UIViewController {

    // MARK: - Properties
    private var detectedBeacons: [MediscanBeacon] = []
    private var isScanning = false

    // MARK: - UI Components
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let scanButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start Scanning", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let permissionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Request Background Permissions", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let uploadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Upload Beacons", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = .systemOrange
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Status: Ready"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let beaconsLabel: UILabel = {
        let label = UILabel()
        label.text = "Detected Beacons (0)"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "BeaconCell")
        return table
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegates()
        setupActions()
    }

    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Mediscan SDK Demo"

        view.addSubview(stackView)
        view.addSubview(beaconsLabel)
        view.addSubview(tableView)

        stackView.addArrangedSubview(scanButton)
        stackView.addArrangedSubview(permissionsButton)
        stackView.addArrangedSubview(uploadButton)
        stackView.addArrangedSubview(statusLabel)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            scanButton.heightAnchor.constraint(equalToConstant: 50),
            permissionsButton.heightAnchor.constraint(equalToConstant: 44),
            uploadButton.heightAnchor.constraint(equalToConstant: 44),

            beaconsLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            beaconsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            beaconsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            tableView.topAnchor.constraint(equalTo: beaconsLabel.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self

        Mediscan.shared.delegate = self
        Mediscan.shared.uploadDelegate = self
    }

    private func setupActions() {
        scanButton.addTarget(self, action: #selector(scanButtonTapped), for: .touchUpInside)
        permissionsButton.addTarget(self, action: #selector(permissionsButtonTapped), for: .touchUpInside)
        uploadButton.addTarget(self, action: #selector(uploadButtonTapped), for: .touchUpInside)
    }

    // MARK: - Actions
    @objc private func scanButtonTapped() {
        if isScanning {
            stopScanning()
        } else {
            startScanning()
        }
    }

    @objc private func permissionsButtonTapped() {
        statusLabel.text = "Status: Requesting background permissions..."
        Mediscan.shared.requestBackgroundPermissions()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.statusLabel.text = "Status: Permission request sent"
        }
    }

    @objc private func uploadButtonTapped() {
        uploadButton.isEnabled = false
        Mediscan.shared.uploadBeacons()
    }

    private func startScanning() {
        let success = Mediscan.shared.startForegroundScanning()
        if success {
            isScanning = true
            scanButton.setTitle("Stop Scanning", for: .normal)
            scanButton.backgroundColor = .systemRed
            statusLabel.text = "Status: Scanning..."
            detectedBeacons.removeAll()
            updateBeaconCount()
        } else {
            statusLabel.text = "Status: Failed to start scanning"
        }
    }

    private func stopScanning() {
        let success = Mediscan.shared.stopScanning()
        if success {
            isScanning = false
            scanButton.setTitle("Start Scanning", for: .normal)
            scanButton.backgroundColor = .systemBlue
            statusLabel.text = "Status: Stopped"
        }
    }

    private func updateBeaconCount() {
        beaconsLabel.text = "Detected Beacons (\(detectedBeacons.count))"
        tableView.reloadData()
    }
}

// MARK: - BeaconScannerDelegate
@available(iOS 14.0, *)
extension ViewController: BeaconScannerDelegate {
    func didDetectBeacon(_ beacon: MediscanBeacon) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            // Add or update beacon in list
            if let index = self.detectedBeacons.firstIndex(where: {
                $0.uuid == beacon.uuid && $0.major == beacon.major && $0.minor == beacon.minor
            }) {
                self.detectedBeacons[index] = beacon
            } else {
                self.detectedBeacons.append(beacon)
            }

            self.updateBeaconCount()
        }
    }

    func didFailWithError(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.statusLabel.text = "Status: Error - \(error.localizedDescription)"
        }
    }
}

// MARK: - MediscanUploadDelegate
@available(iOS 14.0, *)
extension ViewController: MediscanUploadDelegate {
    func uploadDidStart() {
        DispatchQueue.main.async { [weak self] in
            self?.statusLabel.text = "Status: Uploading beacons..."
            self?.uploadButton.setTitle("Uploading...", for: .normal)
        }
    }

    func uploadDidComplete() {
        DispatchQueue.main.async { [weak self] in
            self?.statusLabel.text = "Status: Upload successful"
            self?.uploadButton.setTitle("Upload Beacons", for: .normal)
            self?.uploadButton.isEnabled = true
        }
    }

    func uploadDidFail(error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.statusLabel.text = "Status: Upload failed - \(error.localizedDescription)"
            self?.uploadButton.setTitle("Upload Beacons", for: .normal)
            self?.uploadButton.isEnabled = true
        }
    }
}

// MARK: - UITableViewDataSource & Delegate
@available(iOS 14.0, *)
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detectedBeacons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeaconCell", for: indexPath)
        let beacon = detectedBeacons[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.text = "UUID: \(beacon.uuid.prefix(8))..."
        content.secondaryText = "Major: \(beacon.major) | Minor: \(beacon.minor) | RSSI: \(beacon.rssi) | Accuracy: \(String(format: "%.2f", beacon.accuracy))m"
        content.secondaryTextProperties.font = .systemFont(ofSize: 12)
        content.secondaryTextProperties.color = .secondaryLabel

        cell.contentConfiguration = content
        return cell
    }
}
