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
        case zircon
        case white
        case darkGray
        case blackTop
        case blackBottom

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

            case .zircon:
                return UIColor(named: "zircon") ?? .lightGray

            case .white:
                return UIColor(named: "white") ?? .white

            case .darkGray:
                return UIColor(named: "darkGray") ?? .darkGray

            case .blackTop:
                return UIColor(named: "blackTop") ?? .black

            case .blackBottom:
                return UIColor(named: "blackBottom") ?? .black
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

    enum Fonts {
        static func large() -> UIFont {
            font(of: 25.0)
        }

        static func medium() -> UIFont {
            font(of: 20.0)
        }

        static func small() -> UIFont {
            font(of: 16.0)
        }

        private static func font(of size: CGFloat) -> UIFont {
            UIFont.systemFont(ofSize: size)
        }
    }

    lazy var deviderColor: UIColor = { AppColors.white.color }()

    lazy var titleFont: UIFont = { Fonts.large() }()
    lazy var subTitleFont: UIFont = { Fonts.medium() }()
    lazy var descriptionFont: UIFont = { Fonts.small() }()

    lazy var titleTextColor: UIColor = { AppColors.white.color }()
    lazy var subTitleTextColor: UIColor = { AppColors.white.color }()
    lazy var descriptionTextColor: UIColor = { AppColors.darkGray.color }()

    lazy var descriptionDeviderColor: UIColor = { AppColors.zircon.color }()

    lazy var buttonGradient: [UIColor] = { [AppColors.blackTop.color, AppColors.blackTop.color] }()

    lazy var tipTextColor: UIColor = { AppColors.blackTop.color }()
    lazy var tipBackgroundColor: UIColor = { AppColors.zircon.color }()
}
