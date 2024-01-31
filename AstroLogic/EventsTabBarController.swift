//
//  EventsTabBarController.swift
//  AstroLogic
//
//  Created by Errick Williams on 1/25/24.
//

import Foundation

import SwiftEphemeris
import UIKit
import CoreData


class EventsTabBarController: UITabBarController {
    var selectedDate: Date?
    var chartCake: ChartCake!
    var otherChart: ChartCake!
    var latitude: Double?
    var longitude: Double?
    var notes: String?
    var name: String!
    var event: NSManagedObject?
    init(chartCake: ChartCake, selectedDate: Date, name: String) {
        self.chartCake = chartCake
        self.selectedDate = selectedDate
        self.name = name
        super.init(nibName: nil, bundle: nil)
    }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
    func fetchEventFromCoreData(selectedDate: Date, userName: String) -> (event: NSManagedObject?, photoPaths: [String]?) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserEvent")

        // Update predicate to filter based on both the date and the user's name
        let datePredicate = NSPredicate(format: "eventDate == %@", selectedDate as NSDate)
        let userPredicate = NSPredicate(format: "userID == %@", userName)
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [datePredicate, userPredicate])

        do {
            let fetchedEvents = try managedContext.fetch(fetchRequest)
            if let event = fetchedEvents.first {
                let photoPaths = event.value(forKey: "photoPaths") as? String
                return (event, photoPaths?.split(separator: ",").map(String.init))
            } else {
                print("No event found for the selected date and user.")
                return (nil, nil)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return (nil, nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("EventDetailsViewController loaded with event: \(String(describing: event))")
        print("Debug in EventsTabBarController: \(String(describing: selectedDate)), \(String(describing: chartCake))") // Debugging line 1
        print("Memory address in EventsTabBarController: \(Unmanaged.passUnretained(self).toOpaque())") // Debugging line 2


        let (fetchedEvent, photoPaths) = fetchEventFromCoreData(selectedDate: selectedDate!, userName: name)

        print("Fetched event: \(String(describing: fetchedEvent)), photoPaths: \(String(describing: photoPaths))")

        if let fetchedEvent = fetchedEvent {
            let notes = fetchedEvent.value(forKey: "notes") as? String  // Retrieve notes from the fetched event

            let eventJournal = EventDetailsViewController()
            eventJournal.selectedDate = selectedDate
            eventJournal.chartCake = chartCake
            eventJournal.event = fetchedEvent
            eventJournal.photoPaths = photoPaths
            eventJournal.notes = notes  // Pass the notes to EventDetailsViewController
            eventJournal.title = "Event Journal"
            eventJournal.tabBarItem = UITabBarItem(title: "Journal", image: UIImage(systemName: "book.pages.fill"), tag: 0)
            print("Event being passed to EventDetailsViewController: \(String(describing: eventJournal.event))")
            
            // For Majors (sun symbol is just an example; you may need to find a suitable SF Symbol)
            let progressedAspects = SimpleAllProgressionsAspectedPlanetsViewController()
            progressedAspects.selectedDate = selectedDate
            progressedAspects.chartCake = chartCake
            progressedAspects.tabBarItem = UITabBarItem(title: "Progressed Aspects", image: UIImage(systemName: "point.3.connected.trianglepath.dotted"), tag: 1)

            // For Minors (moon symbol is just an example; you may need to find a suitable SF Symbol)
            let majorProgressedAspects = MajorProgressionsViewController(transitPlanets: [""])
            majorProgressedAspects.selectedDate = selectedDate
            majorProgressedAspects.chartCake = chartCake
            majorProgressedAspects.latitude = latitude
            majorProgressedAspects.longitude = longitude
            majorProgressedAspects.tabBarItem = UITabBarItem(title: "Majors", image: UIImage(systemName: "globe"), tag: 2)

            // For Transits (earth symbol is just an example; you may need to find a suitable SF Symbol)

            let transits = TransitPlanets(transitPlanets: [""])
            transits.selectedDate = selectedDate
            transits.latitude = latitude
            transits.longitude = longitude
            transits.chartCake = chartCake
            transits.tabBarItem = UITabBarItem(title: "Transits", image: UIImage(systemName: "globe"), tag: 3)
            
            let sAAspects = SolarArcProgressionsViewController(transitPlanets: [""])
            sAAspects.selectedDate = selectedDate
            sAAspects.chartCake = chartCake
            sAAspects.latitude = latitude
            sAAspects.longitude = longitude
            sAAspects.tabBarItem = UITabBarItem(title: "Solar Arcs", image: UIImage(systemName: "globe"), tag: 4)



            let minors = MinorProgressionsViewController(transitPlanets: [""])
            minors.selectedDate = selectedDate
            minors.chartCake = chartCake
            minors.latitude = latitude
            minors.longitude = longitude
            minors.tabBarItem = UITabBarItem(title: "Minors", image: UIImage(systemName: "globe"), tag: 5)



            self.viewControllers = [eventJournal, progressedAspects, majorProgressedAspects,transits, sAAspects, minors]

            print("Debug After Set: \(String(describing: progressedAspects.selectedDate)), \(String(describing: progressedAspects.chartCake))")
            _ = progressedAspects.view
            _ = majorProgressedAspects.view
            _ = sAAspects.view
            _ = minors.view
            _ = transits.view

        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     //   print("In viewWillAppear of TabBarController - EventsTabBarController: \(String(describing: selectedDate)), \(String(describing: chartCake))")
    }

    }

