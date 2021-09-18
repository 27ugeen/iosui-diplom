//
//  HabitViewController.swift
//  MyHabits
//
//  Created by GiN Eugene on 22.08.2021.
//

import UIKit

class HabitViewController: UIViewController {
    
    let store = HabitsStore.shared
    
        var habit: Habit? {
            didSet {
                
            }
        }

    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    let contentView: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    let nameHabitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "НАЗВАНИЕ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = UIColor(rgb: 0x000000)
        return label
    }()
    
    var addHabitTextField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        text.tintColor = UIColor(rgb: 0x296DFF)
        text.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: text.frame.height))
        text.leftViewMode = .always
        return text
    }()
    
    let colorTitleHabitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ЦВЕТ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = UIColor(rgb: 0x000000)
        return label
    }()
    
    let colorHabitView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .orange
        view.layer.cornerRadius = 30 / 2
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let timeTitleHabitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ВРЕМЯ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = UIColor(rgb: 0x000000)
        return label
    }()
    
    let timeSubtitleHabitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Каждый день в"
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor(rgb: 0x000000)
        return label
    }()
    
    let setHabitTimeDatePicker: UIDatePicker = {
        let date = UIDatePicker()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.datePickerMode = .countDownTimer
        date.locale = Locale(identifier: "en_US")
        return date
    }()
    
    let deleteHabitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(setupAlert), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureOnColorWheel = UITapGestureRecognizer(target: self, action: #selector(colorWheelTapped))
        self.colorHabitView.addGestureRecognizer(tapGestureOnColorWheel)
        
        setupView()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension HabitViewController {
    func setupView() {
        view.backgroundColor = UIColor(rgb: 0xFFFFFF)
        
        if case navigationController?.title = "Создать" {
            deleteHabitButton.alpha = 0
        } else {
            deleteHabitButton.alpha = 1
        }
        
        let buttonSave = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveHabit))
        let buttonCancel = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelAdding))
        
        buttonSave.tintColor = UIColor(rgb: 0xA116CC)
        buttonCancel.tintColor = buttonSave.tintColor
        
        self.navigationItem.setRightBarButtonItems([buttonSave], animated: true)
        self.navigationItem.setLeftBarButtonItems([buttonCancel], animated: true)
    }
    
    @objc func setupAlert() {
        let currentHabit = store.habits.filter( {$0.dateString == timeSubtitleHabitLabel.text} )[0]
        
        let alert = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \"\(currentHabit.name)\" ?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Удалить", style: UIAlertAction.Style.destructive, handler: { action in
            self.deleteHabit()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func colorWheelTapped() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        colorPicker.selectedColor = colorHabitView.backgroundColor ?? .orange
        colorPicker.isModalInPresentation = true
        colorPicker.title = "Select color"
        self.present(colorPicker, animated: true, completion: nil )
    }
    
    @objc func deleteHabit() {
        let oldHabit = store.habits.filter( {$0.dateString == timeSubtitleHabitLabel.text} )[0]
        guard let indexOfHabit = store.habits.firstIndex(of: oldHabit) else {
            return print("no such index!")
        }
        store.habits.remove(at: indexOfHabit)
        print("habit deleted")
        
        let habitsVC = HabitsViewController()
        let habitsNavVC = UINavigationController(rootViewController: habitsVC)
        habitsNavVC.modalPresentationStyle = .fullScreen
        habitsNavVC.modalTransitionStyle = .flipHorizontal
        self.present(habitsNavVC, animated: true, completion: nil)
    }
    
    @objc private func saveHabit() {
        let newHabit = Habit(name: addHabitTextField.text ?? "",
                             date: setHabitTimeDatePicker.date,
                             color: colorHabitView.backgroundColor ?? .systemOrange)
        
        if case navigationController?.title = "Создать" {
            store.habits.append(newHabit)
        } else {
            let oldHabit = store.habits.filter( {$0.dateString == timeSubtitleHabitLabel.text} )[0]
            
            guard let indexOfHabit = store.habits.firstIndex(of: oldHabit) else {
                return print("no such index!")
            }
            store.habits.remove(at: indexOfHabit)
            store.habits.insert(newHabit, at: indexOfHabit)
        }
        
        let habitsVC = HabitsViewController()
        let habitsNavVC = UINavigationController(rootViewController: habitsVC)
        habitsNavVC.modalPresentationStyle = .fullScreen
        habitsNavVC.modalTransitionStyle = .flipHorizontal
        self.present(habitsNavVC, animated: true, completion: nil)
        
    }
    
    @objc private func cancelAdding() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension HabitViewController {
    func setupConstraints() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(nameHabitLabel)
        contentView.addSubview(addHabitTextField)
        contentView.addSubview(colorTitleHabitLabel)
        contentView.addSubview(colorHabitView)
        contentView.addSubview(timeTitleHabitLabel)
        contentView.addSubview(timeSubtitleHabitLabel)
        contentView.addSubview(setHabitTimeDatePicker)
        contentView.addSubview(deleteHabitButton)
        
        let constraints = [
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            nameHabitLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameHabitLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 21),
            
            addHabitTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            addHabitTextField.topAnchor.constraint(equalTo: nameHabitLabel.bottomAnchor, constant: 7),
            
            colorTitleHabitLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            colorTitleHabitLabel.topAnchor.constraint(equalTo: addHabitTextField.bottomAnchor, constant: 15),
            
            colorHabitView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            colorHabitView.topAnchor.constraint(equalTo: colorTitleHabitLabel.bottomAnchor, constant: 7),
            colorHabitView.widthAnchor.constraint(equalToConstant: 30),
            colorHabitView.heightAnchor.constraint(equalToConstant: 30),
            
            timeTitleHabitLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            timeTitleHabitLabel.topAnchor.constraint(equalTo: colorHabitView.bottomAnchor, constant: 15),
            
            timeSubtitleHabitLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            timeSubtitleHabitLabel.topAnchor.constraint(equalTo: timeTitleHabitLabel.bottomAnchor, constant: 7),
            
            setHabitTimeDatePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            setHabitTimeDatePicker.topAnchor.constraint(equalTo: timeSubtitleHabitLabel.bottomAnchor, constant: 15),
            setHabitTimeDatePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            deleteHabitButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            deleteHabitButton.topAnchor.constraint(equalTo: setHabitTimeDatePicker.bottomAnchor, constant: 240),
            deleteHabitButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            deleteHabitButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -18),
            deleteHabitButton.heightAnchor.constraint(equalToConstant: 22)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        colorHabitView.backgroundColor = viewController.selectedColor
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        print("colorPickerViewcontroller is dismissed")
    }
}

private extension HabitViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
}
