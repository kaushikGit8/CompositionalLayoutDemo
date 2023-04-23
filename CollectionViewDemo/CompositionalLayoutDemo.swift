import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setupCollectionView()
    }
    
    func setupCollectionView() {
        let searchCollectionView = UICollectionView(frame: .zero,
                                                    collectionViewLayout: getCompositionalLayout())
        searchCollectionView.backgroundColor = .gray
        //searchCollectionView.frame = self.view.frame
//        searchCollectionView.register(MyCollectionViewCell.self,
//                                      forCellWithReuseIdentifier: "MyCollectionViewCell")
        let nib = UINib(nibName: "MyCollectionViewCell", bundle: nil)
        searchCollectionView.register(nib,
                                      forCellWithReuseIdentifier: "MyCollectionViewCell")
        let header = UINib(nibName: "HeaderReusableView", bundle: nil)
        searchCollectionView.register(header,
                                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                      withReuseIdentifier: "HeaderReusableView")
        //self.view.addSubview(searchCollectionView)
        self.view.add(view: searchCollectionView,
                      left: 10,
                      right: -10,
                      top: 10,
                      bottom: -10)
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self

    }
    
    func getCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .estimated(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
    
        
        //--------- Group 1 ---------//
        let group1Item1 = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/2),
                                                                   heightDimension: .estimated(1)))
        //group1Item1.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 1, bottom: 1, trailing: 1)


//        let nestedGroup1Item1 = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
//                                                                         heightDimension: .fractionalHeight(1/2)))
//        nestedGroup1Item1.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
//
//        let nestedGroup2Item1 = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/2),
//                                                                         heightDimension: .fractionalHeight(1)))
//        nestedGroup2Item1.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
//
//        let nestedGroup2 = NSCollectionLayoutGroup
//            .horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
//                                          heightDimension: .fractionalHeight(1/2)),
//                        subitems: [nestedGroup2Item1])
//
//        let nestedGroup1 = NSCollectionLayoutGroup
//            .vertical(layoutSize: .init(widthDimension: .fractionalWidth(1/2),
//                                        heightDimension: .fractionalHeight(1)),
//                      subitems: [nestedGroup1Item1, nestedGroup2])

        let group1 = NSCollectionLayoutGroup
            .horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                          heightDimension: .fractionalHeight(1/3)),
                        subitems: [group1Item1])
        ///group1.boundarySupplementaryItems = []
        group1.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 1, bottom: 10, trailing: 1)

        //--------- Group 2 ---------//
        let group2Item1 = NSCollectionLayoutItem(layoutSize: .init(widthDimension:.fractionalWidth(1/2),
                                                                   heightDimension: .fractionalHeight(1)))
        group2Item1.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 1, bottom: 10, trailing: 1)

//        let group2 = NSCollectionLayoutGroup
//            .horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
//                                          heightDimension: .fractionalHeight(1/3)),
//                        subitems: [group2Item1])
        
        let group2 = NSCollectionLayoutGroup
            .horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                          heightDimension: .absolute(50)),
                      subitems: [group2Item1])
        //group2.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 1, bottom: 10, trailing: 1)


        //--------- Container Group ---------//
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(44))
        let headerElement =
        NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        // this activates the "sticky" behavior
        headerElement.pinToVisibleBounds = true
        
        let containerGroup = NSCollectionLayoutGroup
            .vertical(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                        heightDimension: .estimated(600)),
                      subitems: [item, group1, group2])

        let section = NSCollectionLayoutSection(group: containerGroup)
        
        section.boundarySupplementaryItems = [headerElement]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        //UICollectionViewCompositionalLayout()
        return layout
        
        
        /*
         
         //--------- Carousel ---------//
        let carouselItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .absolute(200)))
        carouselItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let carouselGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [caraousalItem])
        
        let carouselSection = NSCollectionLayoutSection(group: carouselGroup)
        carouselSection.orthogonalScrollingBehavior = .paging
        
        carouselSection.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.7
                let maxScale: CGFloat = 1.1
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        
        let layout = UICollectionViewCompositionalLayout(section: carouselSection)
        return layout
         */
    }
}

extension ViewController: UICollectionViewDelegate,
                          UICollectionViewDataSource,
                          UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell",
                                                      for: indexPath) as! MyCollectionViewCell
        //cell.backgroundColor = .red
        cell.text = "kjakjbfkajf akfjbakjfbakfbjkbakjnbf masjbk ckjasbckajbsckj askcjabkajbf"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView
                .dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                  withReuseIdentifier: "HeaderReusableView",
                                                  for: indexPath) as! HeaderReusableView
            //header.configure(with: "Sticky header \(indexPath.section + 1)")
            header.backgroundColor = indexPath.section == 0 ? .blue : .black
            return header
        default:
            let header = collectionView
                .dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                  withReuseIdentifier: "HeaderReusableView",
                                                  for: indexPath) as! HeaderReusableView
            //header.configure(with: "Sticky header \(indexPath.section + 1)")
            return header
        }
    }

//    func supplementary(collectionView: UICollectionView,
//                       kind: String,
//                       indexPath: IndexPath) -> UICollectionReusableView? {
//        let header = collectionView
//            .dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
//                                              withReuseIdentifier: "HeaderReusableView",
//                                              for: indexPath) as! HeaderReusableView
//        //header.configure(with: "Sticky header \(indexPath.section + 1)")
//        return header
//    }
}







extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0.4...1),
                       green: .random(in: 0.4...1),
                       blue: .random(in: 0.4...1),
                       alpha: 1)
    }
}





extension UIView {
    func add(view: UIView, left: CGFloat, right: CGFloat, top: CGFloat, bottom: CGFloat) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: left).isActive = true
        view.rightAnchor.constraint(equalTo: self.rightAnchor, constant: right).isActive = true
        view.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: top).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottom).isActive = true
    }
}
