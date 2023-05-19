import Preferences
import PhotosUI

@available(iOS 14, *)
final class ImagePickerView: PSTableCell, PHPickerViewControllerDelegate, UINavigationControllerDelegate {
    private var thumbnail: UIImage? { .init(contentsOfFile: "/var/mobile/Library/Preferences/\(Metadata.package).png") }
    private var thumbnailView: UIImageView = .init()
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
            let imgSize: CGFloat = frame.size.height - 10
            thumbnailView = .init(frame: CGRect(x: frame.size.width - 50, y: 5, width: imgSize, height: imgSize))
            thumbnailView.backgroundColor = .gray
            thumbnailView.image = thumbnail
            thumbnailView.layer.cornerRadius = 12.0
            thumbnailView.contentMode = .scaleAspectFill
            thumbnailView.clipsToBounds = true
            
            let gesture: UITapGestureRecognizer = .init(target: self, action: #selector(chooseImage))
            addGestureRecognizer(gesture)
            
            subviews.first(where: { $0 is UIButton })?.removeFromSuperview()
            addSubview(thumbnailView)
        }
    }
    
    @objc private func chooseImage() {
        var config: PHPickerConfiguration = .init(photoLibrary: .shared())
        config.selectionLimit = 1
        config.filter = .images
        
        let picker: PHPickerViewController = .init(configuration: config)
        picker.delegate = self
        
        UIApplication.shared.keyWindow?.rootViewController?.present(picker, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true) {
            guard let firstResult: PHPickerResult = results.first,
                  let assetID: String = firstResult.assetIdentifier,
                  let asset: PHAsset = PHAsset.fetchAssets(withLocalIdentifiers: [assetID], options: nil).firstObject
            else {
                return
            }
            
            PHImageManager.default().requestImageDataAndOrientation(for: asset, options: nil) { data, _, _, _ in
                if let data, let image: UIImage = .init(data: data) {
                    self.thumbnailView.image = image
                    try? image.pngData()?.write(to: URL(fileURLWithPath: "/var/mobile/Library/Preferences/\(Metadata.package).png"))
                }
            }
        }
    }
}
