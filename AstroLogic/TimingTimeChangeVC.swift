//
//  TimingTimeChangeVC.swift
//  AstroLogic
//
//  Created by Errick Williams on 12/25/23.

import UIKit
import SwiftEphemeris



class TimingTimeChangeViewController: UIViewController  {
    
    
    weak var delegate: DatePickerDelegate?
    var onDateSelected: ((Date, Date) -> Void)?
    var chartCake: ChartCake?
    var selectedDate: Date?
    var latitude: Double?
    var longitude: Double?
    var delegates: [DatePickerDelegate] = []

       func notifyDateChange(newDate: Date) {
           self.selectedDate = newDate
           delegates.forEach { $0.datePickerDidChangeDate(newDate) }
       }
  
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        let newDate = sender.date
        delegate?.datePickerDidChangeDate(newDate)
        notifyDateChange(newDate: newDate)
    }


    func datePickerDidChangeDate(_ date: Date) {
        // Handle the date change
        self.selectedDate = date
        // Optionally notify other components that need to be aware of the date change
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
        notifyDateChange(newDate: selectedDate)

        // Other necessary actions, such as dismissing the view controller or updating UI, can be added here
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
