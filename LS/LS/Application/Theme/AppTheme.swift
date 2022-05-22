//
//  AppTheme.swift
//  LS
//
//  Created by Viachaslau Kastsechka on 5/22/22.
//

import UIKit

struct AppTheme {

    enum AppColors {

        case lightPink
        case lightOrange
        case teal
        case skyBlue
        case purple
        case hotPink
        case rosePink
        case palePink
        case coral
        case peach
        case turkuoise
        case lagoon

        var color: UIColor {
            switch self {
            case .lightPink:
                return UIColor(named: "lightPink") ?? .systemPink

            case .lightOrange:
                return UIColor(named: "lightOrange") ?? .systemOrange

            case .teal:
                return UIColor(named: "teal") ?? .systemBlue

            case .skyBlue:
                return UIColor(named: "skyBlue") ?? .systemCyan

            case .purple:
                return UIColor(named: "purple") ?? .systemPurple

            case .hotPink:
                return UIColor(named: "hotPink") ?? .systemPink

            case .rosePink:
                return UIColor(named: "rosePink") ?? .systemPink

            case .palePink:
                return UIColor(named: "palePink") ?? .systemPink

            case .coral:
                return UIColor(named: "coral") ?? .systemRed

            case .peach:
                return UIColor(named: "peach") ?? .systemOrange

            case .turkuoise:
                return UIColor(named: "turkuoise") ?? .systemCyan

            case .lagoon:
                return UIColor(named: "lagoon") ?? .systemCyan
            }
        }
    }

    enum Gradient: CaseIterable {
        case roseanna
        case sexyBlue
        case purpleLove
        case piglet
        case lostMemory
        case socialive

        var colors: [UIColor] {
            switch self {
            case .roseanna:
                return [AppColors.lightPink.color, AppColors.lightOrange.color]

            case .sexyBlue:
                return [AppColors.teal.color, AppColors.skyBlue.color]

            case .purpleLove:
                return [AppColors.purple.color, AppColors.hotPink.color]

            case .piglet:
                return [AppColors.rosePink.color, AppColors.palePink.color]

            case .lostMemory:
                return [AppColors.coral.color, AppColors.peach.color]

            case .socialive:
                return [AppColors.turkuoise.color, AppColors.lagoon.color]
            }
        }
    }

    struct Fonts {

    }



}
