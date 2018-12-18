import UIKit
import PlaygroundSupport

class FormTextField: UIView {
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        let label = UILabel()
        let textField = UITextField()
        addSubview(label)
        addSubview(textField)
        NSLayoutConstraint.activate([
          label.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
          label.topAnchor.constraint(equalTo: topAnchor, constant: 0),
          label.heightAnchor.constraint(equalToConstant: 40),
          label.widthAnchor.constraint(equalToConstant: 100),
        ])
        label.text = "Testing"
    }
}

class TextFieldViewController : UIViewController, UITextFieldDelegate {
    
    var label : UILabel!
    var formField : FormTextField!
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        formField = FormTextField()
        formField.configure()
//        formField.borderStyle = .roundedRect
        view.addSubview(formField)
        
        label = UILabel()
        view.addSubview(label)
        
        self.view = view
        formField.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            formField.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20),
            formField.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            formField.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            label.leadingAnchor.constraint(equalTo: formField.leadingAnchor),
            label.topAnchor.constraint(equalTo: formField.bottomAnchor, constant: 10),
            ])
        
        // Events
        
//        textField.addTarget(self, action: #selector(updateLabel), for: UIControl.Event.editingChanged)
        
        updateLabel()
    }
    
    @objc func updateLabel() {
//        self.label.text = formField.text
    }
    
}

PlaygroundPage.current.liveView = TextFieldViewController()
