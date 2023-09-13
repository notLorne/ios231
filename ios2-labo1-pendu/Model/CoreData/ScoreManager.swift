//
//  ScoreManager.swift
//  ios2-labo1-pendu
//
//  Created by Simon Turcotte (Étudiant) on 2023-09-11.
//

import Foundation
import CoreData

class ScoreManager {
    // Core Data context provided by the CoreDataStack
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    // Function to save a high score.
    func saveHighScore(playerName: String, gameMode: Int16, score: Int16) {
        let newHighScore = BestScores(context: context) // Assuming your entity name is "BestScores"
        newHighScore.name = playerName
        newHighScore.mode = gameMode
        newHighScore.score = score

        do {
            try context.save()
            print("High score saved successfully.")
        } catch {
            print("Error saving high score: \(error.localizedDescription)")
        }
    }

    // Function to retrieve high scores for a specific game mode.
    func getHighScores(for gameMode: Int16) -> [BestScores] {
        let fetchRequest: NSFetchRequest<BestScores> = BestScores.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "mode == %d", gameMode)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "score", ascending: false)]

        do {
            let highScores = try context.fetch(fetchRequest)
            return highScores
        } catch {
            print("Error fetching high scores: \(error.localizedDescription)")
            return []
        }
    }

    // Add more methods as needed for managing high scores.
}
