//
//  AddOrEditViewController.swift
//  MyHotels
//
//  Created by Abhishek Vasudev on 23/07/21.
//

import Photos
import UIKit

class AddOrEditViewController: UIViewController {
    
    private let addOrEditViewModel: AddOrEditViewModel
    private let addHotelScreenTitle = "Add Hotel"
    private let editHotelScreenTitle = "Edit Hotel"
    
    private var verticalStackView: UIStackView!
    private var hotelNameTextField: UITextField!
    private var hotelAddressTextField: UITextField!
    private var dateOfStayPicker: UIDatePicker!
    private var roomRateTextField: UITextField!
    private var ratingStackView: UIStackView!
    private var ratingSlider: UISlider!
    private var ratingValueLabel: UILabel!
    private var addPhotoButton: UIButton!
    private var addOrSaveButton: UIButton!
    
    init(addOrEditViewModel: AddOrEditViewModel) {
        self.addOrEditViewModel = addOrEditViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupNavigationBar()
        setupViews()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func setupBackground() {
        if addOrEditViewModel.isEditMode {
            self.view.backgroundColor = MHColorScheme.secondaryColor
        } else {
            self.view.backgroundColor = .orange
        }
    }
    
    private func setupNavigationBar() {
        if addOrEditViewModel.isEditMode {
            self.title = editHotelScreenTitle
            let deleteBarButton = UIBarButtonItem(title: "Delete",
                                                  style: .done,
                                                  target: self,
                                                  action: #selector(deleteButtonAction))
            deleteBarButton.tintColor = .red
            self.navigationItem.rightBarButtonItem = deleteBarButton
            
        } else {
            self.title = addHotelScreenTitle
        }
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: MHColorScheme.secondaryColor]
    }
    
    @objc
    private func deleteButtonAction() {
        addOrEditViewModel.deleteHotel()
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupViews() {
        setupStackView()
        setupHotelNameTextField()
        setupHotelAddressTextField()
        setupDateOfStayPicker()
        setupRoomRateTextField()
        setupRatingSlider()
        setupAddPhotoButton()
        setupAddOrSaveButton()
        addDoneButtonOnKeyboard()
    }
    
    private func setupStackView() {
        verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .equalSpacing
        verticalStackView.alignment = .center
        verticalStackView.spacing = 16.0
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(verticalStackView)
        
        var constraints: [NSLayoutConstraint] = []
        constraints.append(verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(verticalStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100))
        constraints.append(verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(verticalStackView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: -50))
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupHotelNameTextField() {
        hotelNameTextField = createAndInsertTextField(placeHolder: "Enter Name")
        if addOrEditViewModel.isEditMode, let hotel = addOrEditViewModel.getHotel() {
            hotelNameTextField.text = hotel.name
        }
    }
    
    private func setupHotelAddressTextField() {
        hotelAddressTextField = createAndInsertTextField(placeHolder: "Enter Address")
        if addOrEditViewModel.isEditMode, let hotel = addOrEditViewModel.getHotel() {
            hotelAddressTextField.text = hotel.address
        }
    }
    
    private func setupDateOfStayPicker() {
        dateOfStayPicker = UIDatePicker()
        dateOfStayPicker.translatesAutoresizingMaskIntoConstraints = false
        dateOfStayPicker.backgroundColor = UIColor.white
        dateOfStayPicker.datePickerMode = .date
        dateOfStayPicker.maximumDate = Date()
        
        var constraints: [NSLayoutConstraint] = []
        constraints.append(dateOfStayPicker.heightAnchor.constraint(equalToConstant: 50))
        constraints.append(dateOfStayPicker.widthAnchor.constraint(equalToConstant: 350))
        NSLayoutConstraint.activate(constraints)
        
        dateOfStayPicker.addTarget(self, action: #selector(dateOfStayPickerValueChanged(_:)), for: .valueChanged)
        
        if addOrEditViewModel.isEditMode, let hotel = addOrEditViewModel.getHotel() {
            dateOfStayPicker.date = hotel.dateOfStay
        }
        
        verticalStackView.addArrangedSubview(dateOfStayPicker)
    }
    
    @objc
    private func dateOfStayPickerValueChanged(_ sender: UIDatePicker) {
        addOrEditViewModel.setDateOfStay(date: dateOfStayPicker.date)
        checkIfValuesChangedForSave()
    }
    
    private func setupRoomRateTextField() {
        roomRateTextField = createAndInsertTextField(placeHolder: "Enter Room Rate")
        roomRateTextField.keyboardType = .decimalPad
        if addOrEditViewModel.isEditMode, let hotel = addOrEditViewModel.getHotel() {
            roomRateTextField.text = "\(hotel.roomRate)"
        }
    }
    
    private func setupRatingSlider() {
        ratingStackView = UIStackView()
        ratingStackView.axis = .horizontal
        ratingStackView.distribution = .equalCentering
        ratingStackView.alignment = .center
        ratingStackView.spacing = 10.0
        ratingStackView.translatesAutoresizingMaskIntoConstraints = false
        ratingStackView.addBackground(color: .white)
        
        var constraints: [NSLayoutConstraint] = []
        constraints.append(ratingStackView.heightAnchor.constraint(equalToConstant: 50))
        constraints.append(ratingStackView.widthAnchor.constraint(equalToConstant: 350))
        
        let ratingLabel = UILabel()
        ratingLabel.text = " Rating:"
        ratingLabel.textColor = MHColorScheme.secondaryColor
        
        ratingSlider = UISlider()
        ratingSlider.minimumValue = 1
        ratingSlider.maximumValue = 5
        ratingSlider.isContinuous = false
        ratingSlider.tintColor = MHColorScheme.secondaryColor
        ratingSlider.contentScaleFactor = 1.0
        ratingSlider.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(ratingSlider.heightAnchor.constraint(equalToConstant: 25))
        constraints.append(ratingSlider.widthAnchor.constraint(equalToConstant:200))
        
        ratingSlider.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .touchDragInside)
        
        if addOrEditViewModel.isEditMode, let hotel = addOrEditViewModel.getHotel() {
            ratingSlider.setValue(Float(hotel.hotelRating), animated: false)
        } else {
            ratingSlider.setValue(1.0, animated: false)
        }
        
        ratingValueLabel = UILabel()
        if addOrEditViewModel.isEditMode, let hotel = addOrEditViewModel.getHotel() {
            ratingValueLabel.text = "\(hotel.hotelRating) "
        } else {
            ratingValueLabel.text = "1 "
        }
        ratingValueLabel.textColor = MHColorScheme.secondaryColor
        
        ratingStackView.addArrangedSubview(ratingLabel)
        ratingStackView.addArrangedSubview(ratingSlider)
        ratingStackView.addArrangedSubview(ratingValueLabel)
        
        verticalStackView.addArrangedSubview(ratingStackView)
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func sliderValueDidChange(_ sender:UISlider!) {
        let sliderValue = Int(sender.value)
        ratingValueLabel.text = "\(sliderValue) "
        addOrEditViewModel.setRating(rating: sliderValue)
        checkIfValuesChangedForSave()
    }
    
    private func setupAddPhotoButton() {

        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "DefaultHotelImage"), for: .normal)
        button.setTitle("Add Photo", for: .normal)
        button.setTitleColor(MHColorScheme.secondaryColor, for: .normal)
        button.addTarget(self, action: #selector(addPhotoButtonAction), for: .touchUpInside)

        addPhotoButton = button

        var constraints: [NSLayoutConstraint] = []
        constraints.append(addPhotoButton.heightAnchor.constraint(equalToConstant: 150))
        constraints.append(addPhotoButton.widthAnchor.constraint(equalToConstant: 150))
        NSLayoutConstraint.activate(constraints)
        
        if addOrEditViewModel.isEditMode,
           let hotel = addOrEditViewModel.getHotel(),
           let hotelImage = hotel.photo {
            addPhotoButton.setBackgroundImage(hotelImage, for: .normal)
        }

        verticalStackView.addArrangedSubview(addPhotoButton)
    }
    
    @objc
    private func addPhotoButtonAction() {
        didTapAddPhotoButton()
    }
    
    private func setupAddOrSaveButton() {
        addOrSaveButton = UIButton(type: .system)
        addOrSaveButton.translatesAutoresizingMaskIntoConstraints = false
        addOrSaveButton.backgroundColor = .cyan
        
        if addOrEditViewModel.isEditMode {
            addOrSaveButton.setTitle("Save", for: .normal)
            addOrSaveButton.isEnabled = addOrEditViewModel.hasValueChanged
            addOrSaveButton.alpha = 0.5
        } else {
            addOrSaveButton.setTitle("Add", for: .normal)
        }
        
        addOrSaveButton.setTitleColor(MHColorScheme.secondaryColor, for: .normal)
        addOrSaveButton.addTarget(self, action: #selector(addOrSaveButtonAction), for: .touchUpInside)
        
        var constraints: [NSLayoutConstraint] = []
        constraints.append(addOrSaveButton.heightAnchor.constraint(equalToConstant: 50))
        constraints.append(addOrSaveButton.widthAnchor.constraint(equalToConstant: 350))
        NSLayoutConstraint.activate(constraints)
        
        verticalStackView.addArrangedSubview(addOrSaveButton)
    }
    
    @objc
    private func addOrSaveButtonAction() {
        if addOrEditViewModel.isEditMode {
            addOrEditViewModel.editHotel()
        } else {
            addOrEditViewModel.addHotel()
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    private func createAndInsertTextField(placeHolder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeHolder
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .line
        textField.backgroundColor = UIColor.white
        textField.textColor = MHColorScheme.primaryColor
        
        var constraints: [NSLayoutConstraint] = []
        constraints.append(textField.heightAnchor.constraint(equalToConstant: 50))
        constraints.append(textField.widthAnchor.constraint(equalToConstant: 350))
        NSLayoutConstraint.activate(constraints)
        
        verticalStackView.addArrangedSubview(textField)
        
        return textField
    }
    
    private func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "Done",
                                                          style: UIBarButtonItem.Style.done,
                                                          target: self,
                                                          action: #selector(keyBoardToolBarDoneButtonAction))
        
        let doneToolbarItems = [flexSpace, doneButton]
        
        doneToolbar.items = doneToolbarItems
        doneToolbar.sizeToFit()
        
        self.hotelNameTextField.inputAccessoryView = doneToolbar
        self.hotelAddressTextField.inputAccessoryView = doneToolbar
        self.roomRateTextField.inputAccessoryView = doneToolbar
    }
    
    @objc
    private func keyBoardToolBarDoneButtonAction() {
        self.hotelNameTextField.resignFirstResponder()
        self.hotelAddressTextField.resignFirstResponder()
        self.roomRateTextField.resignFirstResponder()
        addOrEditViewModel.setName(name: hotelNameTextField.text ?? "NA")
        addOrEditViewModel.setAddress(address: hotelAddressTextField.text ?? "NA")
        let roomRateInt = Int(roomRateTextField.text ?? "0") ?? 0
        addOrEditViewModel.setRoomRate(roomRate: roomRateInt)
        checkIfValuesChangedForSave()
    }
    
    func didTapAddPhotoButton() {
        let alertController = UIAlertController(title: "Camera or Saved Photos?", message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (pAction) in
            alertController.dismiss(animated: true, completion: nil)
        })
        
        let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default, handler: { (pAction) in
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            
            alertController.dismiss(animated: true, completion: nil)
            self.present(picker, animated: true, completion: nil)
        })
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { (pAction) in
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .camera
            
            alertController.dismiss(animated: true, completion: nil)
            self.present(picker, animated: true, completion: nil)
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cameraAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func checkIfValuesChangedForSave() {
        addOrEditViewModel.checkIfValuesChanged()
        addOrSaveButton.isEnabled = addOrEditViewModel.hasValueChanged
        addOrSaveButton.alpha = addOrEditViewModel.hasValueChanged ? 1 : 0.5
    }
}

extension AddOrEditViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[.originalImage] as? UIImage {
            addOrEditViewModel.setImage(image: image)
            addPhotoButton.setBackgroundImage(image, for: .normal)
            checkIfValuesChangedForSave()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension AddOrEditViewController: UINavigationControllerDelegate {}

extension AddOrEditViewController: UITextFieldDelegate {}
