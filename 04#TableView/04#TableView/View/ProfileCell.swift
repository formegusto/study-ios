import UIKit

class ProfileCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // TableView 시작 시점
        let profileHeight = 64
        self.profileImage.layer.cornerRadius = CGFloat(profileHeight / 2)
        
        self.contentView.layer.cornerRadius = 12
        self.contentView.backgroundColor = .white
        self.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
