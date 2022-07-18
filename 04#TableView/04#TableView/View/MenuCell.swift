import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var iconWrapper: UIView!
    @IBOutlet weak var splitLine: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setViewStyle(isFirst: Bool?, isLast: Bool?, menu: Menu) -> Void {
        if (isFirst != nil) && isFirst! {
            self.contentView.layer.cornerRadius = 12
            self.contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        
        if (isLast != nil) && isLast! {
            self.contentView.layer.cornerRadius = 12
            self.contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
        
        self.contentView.backgroundColor = .white
        self.backgroundColor = .clear
        
        self.iconImage.image = UIImage.init(systemName: menu.iconName)
        self.iconWrapper.layer.backgroundColor = menu.iconColor.cgColor
        self.iconWrapper.layer.cornerRadius = CGFloat(8)
        
        self.titleLabel.text = menu.title
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
