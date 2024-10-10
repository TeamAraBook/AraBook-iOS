//
//  UIImageView+.swift
//  AraBook
//
//  Created by 고아라 on 10/8/24.
//

import UIKit

extension UIImageView {
   
    /// Adds a blur effect to the UIImageView
    /// - Parameters:
    ///   - style: UIBlurEffect.Style, default is .light
    func addBlurEffect(style: UIBlurEffect.Style) {
        // Check if the blur effect is already added
        if !subviews.contains(where: { $0 is UIVisualEffectView }) {
            let blurEffect = UIBlurEffect(style: style)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.addSubview(blurEffectView)
        }
    }
    
    /// Removes the blur effect from the UIImageView
    func removeBlurEffect() {
        // Remove any UIVisualEffectView subviews
        subviews.filter { $0 is UIVisualEffectView }.forEach { $0.removeFromSuperview() }
      
    // 이미지 로드 함수 (URL로부터 이미지를 로드하고, 크롭한 후 UIImageView에 설정)
    func loadAndCropImage(from urlString: String, cropRect: CGRect) {
        guard let url = URL(string: urlString) else { return }

        // URLSession을 통해 이미지를 비동기적으로 다운로드
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Failed to load image: \(error.localizedDescription)")
                return
            }

            guard let data = data, let image = UIImage(data: data) else { return }

            // 이미지 로드 후 메인 스레드에서 UI 업데이트
            DispatchQueue.main.async {
                // 이미지를 크롭
                let croppedImage = image.crop(to: cropRect)
                // UIImageView에 크롭된 이미지를 설정
                self?.image = croppedImage
            }
        }.resume()
    }
}

extension UIImage {
    // 이미지를 주어진 CGRect로 크롭하는 함수
    func crop(to rect: CGRect) -> UIImage? {
        guard let cgImage = self.cgImage?.cropping(to: rect) else { return nil }
        return UIImage(cgImage: cgImage)
    }
}
