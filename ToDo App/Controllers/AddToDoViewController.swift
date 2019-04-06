//
//  AddToDoViewController.swift
//  ToDo App
//
//  Created by Avinash Reddy on 4/5/19.
//  Copyright © 2019 Avinash Reddy. All rights reserved.
//

import UIKit
import CoreData

class AddToDoViewController: UIViewController {
    
    // MARK: - Properties
    var managedContext: NSManagedObjectContext!
    
    // MArK: Outlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // listen to keyboard notification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        textView.becomeFirstResponder()
    }
    
    @objc func keyboardWillShow(with notification: Notification) {
        let key = "UIKeyboardFrameEndUserInfoKey"
        guard let keyboardFrame = notification.userInfo?[key] as? NSValue else {
            return
        }
        
        let keyboardHeight = keyboardFrame.cgRectValue.height
        
        bottomConstraint.constant = keyboardHeight + 16 // for adding gap between keyboard and cancel button
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func doneTapped(_ sender: UIButton) {
        guard let title = textView.text, !title.isEmpty else {
            return
        }
        let todo = Todo(context: managedContext)
        todo.title = title
        todo.priority = Int16(segmentControl.selectedSegmentIndex)
        todo.date = Date()
        
        do {
            try managedContext.save()
            dismiss(animated: true, completion: nil)
            textView.resignFirstResponder()
        } catch {
            print("Error saving todo: \(error)")
        }
    }
    
    @IBAction func closeTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        textView.resignFirstResponder()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}

extension AddToDoViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if doneButton.isHidden {
            textView.text.removeAll()
            textView.textColor = .white
            
            doneButton.isHidden = false
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
}
