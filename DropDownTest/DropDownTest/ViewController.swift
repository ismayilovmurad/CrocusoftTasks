//
//  ViewController.swift
//  DropDownTest
//
//  Created by Nihad Ismayilov on 14.12.23.
//

import UIKit

class ViewController: UIViewController {
    
    var filterData: [(id: Int, title: String)] = [
        (1, "First"),
        (2, "Second"),
        (3, "Third"),
        (4, "Fourth"),
        (5, "Fifth"),
        (6, "Sixth"),
    ]
    
    var isVisible = false {
        didSet {
            if isVisible {
                showDropDown()
            } else {
                hideDropDown()
            }
        }
    }
    
    lazy var dismissGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissTap))
        gesture.cancelsTouchesInView = false
        return gesture
    }()
    
    private lazy var searchTextField: UITextField = {
        let tf = UITextField()
        view.addSubview(tf)
        tf.delegate = self
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .none
        tf.layer.cornerRadius = 9
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.borderWidth = 1
        tf.placeholder = "Drop down test"
        
        return tf
    }()
    
    var dropDownHeight: NSLayoutConstraint!
    private lazy var dropDownTableView: UITableView = {
        let tv = UITableView()
        view.addSubview(tv)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.layer.cornerRadius = 8
        tv.layer.borderColor = UIColor.lightGray.cgColor
        tv.layer.borderWidth = 1
        
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(dismissGesture)
        setup()
    }
    
    private func setup() {
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            searchTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            searchTextField.heightAnchor.constraint(equalToConstant: 36)
        ])
        NSLayoutConstraint.activate([
            dropDownTableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 8),
            dropDownTableView.leftAnchor.constraint(equalTo: searchTextField.leftAnchor),
            dropDownTableView.rightAnchor.constraint(equalTo: searchTextField.rightAnchor),
        ])
        dropDownHeight = dropDownTableView.heightAnchor.constraint(equalToConstant: 0)
        dropDownHeight.isActive = true
    }
    
    @objc private func dismissTap(_ sender: UITapGestureRecognizer){
        let tapLocation = sender.location(in: dropDownTableView)
        if dropDownTableView.bounds.contains(tapLocation) {
            return
        }
        view.endEditing(true)
    }
    
    func showDropDown() {
        dropDownTableView.isHidden = false
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            dropDownTableView.reloadData()
            dropDownHeight.constant = dropDownTableView.contentSize.height
            view.layoutIfNeeded()
        }
    }
    
    func hideDropDown() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            dropDownHeight.constant = 0
            view.layoutIfNeeded()
        } completion: { [weak self] isComplete in
            guard let self else { return }
            if isComplete {
                dropDownTableView.isHidden = true
            }
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isVisible = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        isVisible = false
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = filterData[indexPath.row].title
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchTextField.text = filterData[indexPath.row].title
        searchTextField.resignFirstResponder()
    }
}

