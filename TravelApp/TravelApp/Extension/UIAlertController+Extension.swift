//
//  UIAlertController+Extension.swift
//  TravelApp
//
//  Created by Serhat  Şimşek  on 16.05.2024.
//

import UIKit

extension UIAlertController {
    //MARK: Base Func
    private static func showBasicAlarm(title: String, message: String?, on vc: UIViewController) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .destructive, handler: nil))
            vc.present(alert, animated: true)
        }
    }

    //MARK: Validation Alerts
    public static func showInvalidEmailAlert(vc: UIViewController) {
        showBasicAlarm(title: "Geçersiz Email", message: "Lütfen geçerli bir e-mail giriniz", on: vc)
    }
    public static func showInvalidPasswordAlert(vc: UIViewController) {
        showBasicAlarm(title: "Geçersiz Şifre", message: "Lütfen geçerli bir e-mail giriniz\nMinimum 6 maksimum 12 karakter olmalıdır.", on: vc)
    }
    
    //MARK: Registration Alerts
    public static func showRegistrationSuccessAlert(on vc: UIViewController) {
        showBasicAlarm(title: "Kayıt Başarılı", message: "Giriş yapabilirsiniz" , on: vc)
    }
    public static func showRegistrationErrorAlert(on vc: UIViewController) {
        showBasicAlarm(title: "Bilinmeyen Kayıt Hatası", message: nil , on: vc)
    }
    public static func showRegistrationErrorAlert(on vc: UIViewController, error: Error) {
        showBasicAlarm(title: "Kayıt Hatası", message: "\(error.localizedDescription)" , on: vc)
    }
    
    //MARK: Sign In Alerts
    public static func showSignInErrorAlert(on vc: UIViewController) {
        showBasicAlarm(title: "Bilinmeyen Giriş Hatası", message: nil , on: vc)
    }
    public static func showSignInErrorAlert(on vc: UIViewController, error: Error) {
        showBasicAlarm(title: "Giriş Hatası", message: "\(error.localizedDescription)" , on: vc)
    }
    
    //MARK: Log Out Error
    public static func showLogoutErrorAlert(on vc: UIViewController, error: Error) {
        showBasicAlarm(title: "Çıkış Hatası", message: "\(error.localizedDescription)" , on: vc)
    }
    
    //MARK: Forgot Password Alerts
    public static func showPasswordResetRequestSuccessAlert(on vc: UIViewController) {
        showBasicAlarm(title: "Şifre Sıfırlama İsteği Başarılı", message: nil, on: vc)
    }
    public static func showPasswordResetRequestErrorAlert(on vc: UIViewController, error: Error) {
        showBasicAlarm(title: "Şifre Sıfırlama Hatası", message: "\(error.localizedDescription)" , on: vc)
    }
    
    //MARK: - Fetching User Errors
    public static func showFetchingUserErrorAlert(on vc: UIViewController, error: Error) {
        showBasicAlarm(title: "Veriler Çekilemedi", message: "\(error.localizedDescription)" , on: vc)
    }
    public static func showUnknownFetchingUserErrorAlert(on vc: UIViewController, error: Error) {
        showBasicAlarm(title: "Bilinmeyen Veri Çekme Hatası", message: nil , on: vc)
    }
}
