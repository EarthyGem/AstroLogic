import UIKit
import SwiftEphemeris
import CoreData

class EventListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // Add a table view to your storyboard or create it programmatically
    let tableView = UITableView()
    var chartCake: ChartCake!
    var events: [NSManagedObject] = []
    var latitude: Double!
    var longitude: Double!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CustomEventCell.self, forCellReuseIdentifier: "EventCell")
        // Initialize and configure the table view
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)

        // Register a table view cell class or use a custom cell

        // Fetch the saved events from Core Data
        fetchEvents()
    }

    
    // Function to fetch events from Core Data
    func fetchEvents() {
        // Implement the logic to fetch events from Core Data here
        // You should replace this with your actual Core Data fetch request
        
        // For demonstration purposes, let's assume you have an entity named "UserEvent"
        // and you want to fetch all UserEvent objects
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserEvent")
        
        do {
            events = try managedContext.fetch(fetchRequest)
            tableView.reloadData() // Reload the table view with the fetched events
        } catch let error as NSError {
            print("Could not fetch events. \(error), \(error.userInfo)")
        }
    }

    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! CustomEventCell
        
        // Configure the cell with event information
        let event = events[indexPath.row]
        if let eventType = event.value(forKeyPath: "eventType") as? String,
           let eventDate = event.value(forKey: "eventDate") as? Date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none // This will remove the time
            let formattedDate = dateFormatter.string(from: eventDate)
            
            cell.configure(with: eventType, eventDate: formattedDate)
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
          if editingStyle == .delete {
              // Handle the deletion of the event
              deleteEvent(at: indexPath)
          }
      }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = events[indexPath.row]

        // Assuming you have a way to retrieve the latitude and longitude
        // You might be storing these in your event object
   
        let selectedDate = event.value(forKey: "eventDate") as? Date ?? Date()

        // Assuming ChartCake can be initialized with the event details
        // Replace this with the actual data you need to pass
        if let chartCake = chartCake {
            let nextViewController = EventsTabBarController(chartCake: ChartCake(birthDate: chartCake.natal.birthDate, latitude: latitude!, longitude: longitude!, transitDate: selectedDate)!, selectedDate: selectedDate)


            
            // Push the nextViewController or present it modally
            navigationController?.pushViewController(nextViewController, animated: true)
            // OR
            // present(nextViewController, animated: true, completion: nil)
        }
    }




      // Function to delete an event
      func deleteEvent(at indexPath: IndexPath) {
          let eventToDelete = events[indexPath.row]

          // Implement the logic to delete the event from Core Data
          // You should replace this with your actual Core Data deletion code

          let appDelegate = UIApplication.shared.delegate as! AppDelegate
          let managedContext = appDelegate.persistentContainer.viewContext

          // Delete the event object from Core Data
          managedContext.delete(eventToDelete)

          do {
              // Save the managed context to persist the deletion
              try managedContext.save()
              
              // Remove the event from the events array
              events.remove(at: indexPath.row)
              
              // Delete the row from the table view
              tableView.deleteRows(at: [indexPath], with: .fade)
          } catch let error as NSError {
              print("Could not delete event. \(error), \(error.userInfo)")
          }
      }
  }
