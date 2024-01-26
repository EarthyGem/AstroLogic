import UIKit
import CoreML
import NaturalLanguage

class AstrologyViewController: UIViewController {
    
    let questionTextField = UITextField()
    let submitButton = UIButton()
    let replyLabel = UILabel()
    
    var trainedModel: HouseClassifier? // Use the correct name of your model class
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Load the Core ML model
        trainedModel = HouseClassifier()
    }
    
    // ... [Setup UI Code] ...
    
    @IBAction func submitQuestion(_ sender: UIButton) {
          let question = questionTextField.text ?? ""
          predictAstrologicalInfluences(question: question)
      }

      func predictAstrologicalInfluences(question: String) {
          guard let model = trainedModel else {
              replyLabel.text = "Model is not available."
              return
          }

          do {
              // Assuming the model takes a single string input and returns a string output
              let prediction = try model.prediction(text: question)
              updateReplyLabel(with: prediction.label)
          } catch {
              print("Error during prediction: \(error)")
              replyLabel.text = "Error in prediction."
          }
      }

      func updateReplyLabel(with prediction: String) {
          // Parse the prediction to format it as required
          let formattedPrediction = formatPrediction(prediction)
          replyLabel.text = "This question is related to: \(formattedPrediction)"
      }

      func formatPrediction(_ prediction: String) -> String {
          // Split the prediction into house and planets and format it
          let components = prediction.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
          let formatted = components.joined(separator: ", ")
          return formatted
      }

    
    func setupUI() {
        // Position and size of the question text field
        questionTextField.frame = CGRect(x: 20, y: 100, width: view.frame.size.width - 40, height: 40)
        questionTextField.borderStyle = .roundedRect
        questionTextField.placeholder = "Enter your question here"
        
        // Position and size of the submit button
        submitButton.frame = CGRect(x: 20, y: 150, width: view.frame.size.width - 40, height: 40)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.backgroundColor = .blue
        submitButton.addTarget(self, action: #selector(submitQuestion), for: .touchUpInside)
        
        // Position and size of the reply label
        replyLabel.frame = CGRect(x: 20, y: 200, width: view.frame.size.width - 40, height: 100)
        replyLabel.numberOfLines = 0
        replyLabel.textAlignment = .center
        replyLabel.textColor = .white
        
        // Add elements to the view
        view.addSubview(questionTextField)
        view.addSubview(submitButton)
        view.addSubview(replyLabel)
    }
    
}
