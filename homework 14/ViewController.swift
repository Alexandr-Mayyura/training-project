
import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.clearsOnBeginEditing = true
        lastNameTextField.clearsOnBeginEditing = true
        nameLabel.text = Persistenc.shared.userName
        lastNameLabel.text = Persistenc.shared.userLastName
        
        nameTextField.delegate = self
        lastNameTextField.delegate = self
        
        nameTextField.returnKeyType = UIReturnKeyType.continue
        lastNameTextField.returnKeyType = UIReturnKeyType.go
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        nameLabel.text =  nameTextField.text
        lastNameLabel.text = lastNameTextField.text
        
        
        
        Persistenc.shared.userName = nameLabel.text
        Persistenc.shared.userLastName = lastNameLabel.text
        
        switch textField {
        case nameTextField: lastNameTextField.becomeFirstResponder()
        default: textField.resignFirstResponder()
        }
        
       return true
     }
    
}

