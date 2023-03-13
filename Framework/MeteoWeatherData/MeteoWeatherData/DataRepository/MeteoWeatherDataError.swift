//
//  MeteoWeatherDataError.swift
//  MeteoWeatherData
//
//  Created by Koussaïla Ben Mamar on 10/03/2023.
//

import Foundation

public enum MeteoWeatherDataError: String, Error {
    case localDatabaseError = "Une erreur est survenue au niveau de la base de données locale."
    case localDatabaseFetchError = "Une erreur est survenue lors de la récupération des données de la base de données locale."
    case localDatabaseDeleteError = "Une erreur est survenue lors de la suppression d'une entité dans la base de données locale."
    case localDatabaseDeleteConflictError = "Une erreur est survenue lors de la suppression d'une entité conflictuelle dans la base de données locale."
    case localDatabaseSavingError = "Une erreur est survenue lors de la sauvegarde dans la base de données locale."
    case parametersMissing = "Erreur 400: Paramètres manquants dans la requête."
    case invalidApiKey = "Erreur 401: La clé d'API fournie est inactive, invalide ou inexistante."
    case notFound = "Erreur 404: Aucun contenu disponible."
    case tooManyRequests = "Erreur 429: Trop de requêtes ont été effectuées dans un laps de temps (60 appels/minute). Veuillez réessayer ultérieurement."
    case serverError = "Erreur 500: Erreur serveur."
    case apiError = "Une erreur est survenue."
    case invalidURL = "Erreur: URL invalide."
    case networkError = "Une erreur est survenue, pas de connexion Internet."
    case decodeError = "Une erreur est survenue au décodage des données téléchargées."
    case downloadError = "Une erreur est survenue au téléchargement des données."
    case unknown = "Erreur inconnue."
}
