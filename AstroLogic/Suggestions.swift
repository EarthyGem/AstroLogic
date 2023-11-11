import UIKit
import MapKit

class SuggestionsViewController: UIViewController, UITextFieldDelegate, MKLocalSearchCompleterDelegate {

    var autocompleteSuggestions: [MKLocalSearchCompletion] = []
    let searchCompleter = MKLocalSearchCompleter()
    weak var delegate: SuggestionsViewControllerDelegate?

    lazy var placeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Place"
        textField.borderStyle = .roundedRect
        textField.delegate = self
        return textField
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupSearchCompleter()
    }

    func setupViews() {
        view.addSubview(placeTextField)
        view.addSubview(tableView)

        placeTextField.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            placeTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            placeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            placeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            placeTextField.heightAnchor.constraint(equalToConstant: 40),

            tableView.topAnchor.constraint(equalTo: placeTextField.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupSearchCompleter() {
        searchCompleter.delegate = self
        searchCompleter.resultTypes = .address
    }

    // MARK: - UITextFieldDelegate

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == placeTextField {
            if let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) {
                searchCompleter.queryFragment = text
            }
        }
        return true
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        // Street indicators with only the first letter uppercased
        let streetIndicators = ["St", "Rd", "Ave", "Ct","Cir","Pl","Dr", "Lane", "Blvd", "Drive", "Way", "Street", "Road", "Avenue", "Court", "Ln", "Boulevard", "Drive", "Terrace", "Place", "Path", "Trail", "Tr", "Trl", "Plaza"]

        // Filter results
        autocompleteSuggestions = completer.results.filter { suggestion in
            let components = suggestion.title.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }

            if components.count == 2 {
                // Likely "City, State" or "City, Country"
                return true
            } else if components.count == 1 {
                // Check for absence of street address indicators
                let words = components[0].split(separator: " ").map { String($0) }
                return !words.contains(where: { streetIndicators.contains($0) })
            }
            return false
        }
        tableView.reloadData()
    }


}

extension SuggestionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autocompleteSuggestions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let suggestion = autocompleteSuggestions[indexPath.row]

        // Combine the title and subtitle
        let combinedText = "\(suggestion.title) \(suggestion.subtitle)"
        cell.textLabel?.text = combinedText
        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSuggestion = autocompleteSuggestions[indexPath.row]
        delegate?.suggestionSelected(selectedSuggestion)
        dismiss(animated: true, completion: nil)
    }
}

protocol SuggestionsViewControllerDelegate: AnyObject {
    func suggestionSelected(_ suggestion: MKLocalSearchCompletion)
}
