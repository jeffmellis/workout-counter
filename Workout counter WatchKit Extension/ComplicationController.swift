//
//  ComplicationController.swift
//  Workout counter WatchKit Extension
//
//  Created by jeff mellis on 2019-08-14.
//  Copyright © 2019 jeff mellis. All rights reserved.
//

import ClockKit

//@NSCopying var textProvider: CLKTextProvider { get set }
//CLKComplicationTemplate
class ComplicationController: NSObject, CLKComplicationDataSource {
    

    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        let defaults = UserDefaults.standard
        let countFromApp = defaults.string(forKey: "count")
        let count = countFromApp ?? "0"
        
        var entry: CLKComplicationTimelineEntry?
        if (complication.family == .modularSmall) {
            let template = CLKComplicationTemplateModularSmallSimpleText()
            template.textProvider = CLKSimpleTextProvider(text: String(count))
            entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
        }
        
        handler(entry)
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        handler(nil)
    }
    
}
