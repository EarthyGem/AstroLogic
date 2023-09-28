//
//  TimeChangeViewController.swift
//  MVP
//
//  Created by Errick Williams on 2/25/23.
//

import UIKit
import SwiftEphemeris



class ProgressedPlanetsTimeChangeViewController: UIViewController  {
    
    
    weak var delegate: DatePickerDelegate?
    var onDateSelected: ((Date, Date) -> Void)?
    var chartCake: ChartCake?
    var selectedDate: Date?
    var name: String!

    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        delegate?.datePickerDidChangeDate(sender.date)
    }

    

    
   public let tcDP: UIDatePicker = {
        let tcDP = UIDatePicker()
        tcDP.datePickerMode = .dateAndTime
        tcDP.preferredDatePickerStyle = .inline
        tcDP.backgroundColor = .white
        tcDP.tintColor = .green
       tcDP.date = Date()
        return tcDP
    }()

  
    @IBAction func doneButtonTapped(_ sender: UIToolbar) {
        let selectedDate = tcDP.date

        // Create an instance of the next view controller
        let nextViewController = MajorProgressionsViewController(MP_Planets: [""])
// Set the
        nextViewController.chartCake = chartCake?.withUpdatedTransitDate(selectedDate)
        nextViewController.selectedDate = selectedDate
        nextViewController.name = name
        navigationController?.pushViewController(nextViewController, animated: true)
    }




    
    @objc func dismissDatePicker() {
        
     
    
           

           // Hide the date picker
           view.endEditing(true)
       }
    
    
      private let planetIntro: UILabel = {
          let planetIntro = UILabel()
          
          
          return planetIntro
          
      }()
      
      private let planetIntro1: UILabel = {
          let planetIntro1 = UILabel()
          
          
          return planetIntro1
          
      }()
      
      
      
      private let planetIntro2: UILabel = {
          let planetIntro2 = UILabel()
          
          
          return planetIntro2
          
      }()
      
      
      private let planetIntro3: UILabel = {
          let planetIntro3 = UILabel()
          
          
          return planetIntro3
          
      }()
      
      
      override func viewDidLoad() {
          super.viewDidLoad()

 tcDP.frame = CGRect(x: 0, y: 150, width: 400, height: 450)
        tcDP.tintColor = UIColor(red: 0.6, green: 0.6, blue: 0.75, alpha: 1)
        tcDP.backgroundColor = UIColor(red: 236/255, green: 239/255, blue: 244/255, alpha: 1)
        view.addSubview(tcDP)

        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 550, width: 400, height: 40)
        toolbar.backgroundColor = UIColor(red: 236/255, green: 239/255, blue: 244/255, alpha: 1)
        toolbar.tintColor = UIColor(red: 0.6, green: 0.6, blue: 0.75, alpha: 1)
        toolbar.barTintColor = UIColor(red: 0.9, green: 0.9, blue: 0.98, alpha: 1)
        
        // Create a "Done" button for the toolbar
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        
        // Create flexible space bar button items
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        // Add flexible spaces and the "Done" button to the toolbar
        toolbar.setItems([flexibleSpace, doneButton, flexibleSpace], animated: true)
        
        

        // Set the toolbar as the input accessory view of the date picker
        view.addSubview(toolbar)
          
          
          // Do any additional setup after loading the view.
      }

      
      override func viewDidLayoutSubviews() {
          super.viewWillLayoutSubviews()

          view.backgroundColor = .black
  //        title = myPlanetsText.uppercased()
  //
         
          
      }

 

  }
