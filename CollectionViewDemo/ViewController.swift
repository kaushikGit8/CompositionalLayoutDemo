//
//  ViewController.swift
//  CollectionViewDemo
//
//  Created by Kaushik on 19/11/22.
//

import UIKit

class ViewController2: UIViewController {
    
    var searchCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setupCollectionView()
    }
    
    
    func setupCollectionView() {
        searchCollectionView = UICollectionView(frame: .zero,
                                                    collectionViewLayout: compositionalLayout)
        //compositionalLayout.configuration.interSectionSpacing = 5
        
        
        searchCollectionView.backgroundColor = .white
        
        let nib11 = UINib(nibName: "TwoLabelCollectionViewCell", bundle: nil)
        searchCollectionView.register(nib11,
                                      forCellWithReuseIdentifier: "TwoLabelCollectionViewCell")
        
        let nib = UINib(nibName: "MyCollectionViewCell", bundle: nil)
        searchCollectionView.register(nib,
                                      forCellWithReuseIdentifier: "MyCollectionViewCell1")
        
        let nib1 = UINib(nibName: "MyCollectionViewCell", bundle: nil)
        searchCollectionView.register(nib1,
                                      forCellWithReuseIdentifier: "MyCollectionViewCell2")
        
        let nib2 = UINib(nibName: "MyCollectionViewCell", bundle: nil)
        searchCollectionView.register(nib2,
                                      forCellWithReuseIdentifier: "MyCollectionViewCell3")
        
        let nib3 = UINib(nibName: "MyCollectionViewCell", bundle: nil)
        searchCollectionView.register(nib3,
                                      forCellWithReuseIdentifier: "MyCollectionViewCell4")
        
        let nib4 = UINib(nibName: "MyCollectionViewCell", bundle: nil)
        searchCollectionView.register(nib4,
                                      forCellWithReuseIdentifier: "MyCollectionViewCell5")
         self.view.add(view: searchCollectionView,
                      left: 10,
                      right: -10,
                      top: 10,
                      bottom: -10)
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
    }
    
    fileprivate func compactLayout() -> NSCollectionLayoutSection? {
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .estimated(40))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Container Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(40))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
        return section
    }
    
    fileprivate func regularLayout(_ sectionIndex: Int) -> NSCollectionLayoutSection? {
        let fraction: CGFloat = 1 / 2
        let inset: CGFloat = 5
        
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .estimated(40))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset,
                                                     leading: inset,
                                                     bottom: inset,
                                                     trailing: inset)
        
        // first group items - 3 and second group items-  7
        // third group items - 3 and fourth group items - 7
        let subItems1 = (0...2).compactMap { _ in item }
        let subItems2 = (0...6).compactMap { _ in item }
        let subItems3 = (0...6).compactMap { _ in item }
        let subItems4 = (0...2).compactMap { _ in item }
        
        // Group
       
        //group1.interItemSpacing = .fixed(5)
        
        let groupSize11 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .estimated(40))
        let group11 = NSCollectionLayoutGroup.vertical(layoutSize: groupSize11,
                                                       subitems: subItems1)
        
        let groupSize12 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .estimated(40))
        let group12 = NSCollectionLayoutGroup.vertical(layoutSize: groupSize12,
                                                      subitems: subItems2)

        
        let groupSize21 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .estimated(40))
        let group21 = NSCollectionLayoutGroup.vertical(layoutSize: groupSize21,
                                                      subitems: subItems3)
        
        let groupSize22 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .estimated(40))
        let group22 = NSCollectionLayoutGroup.vertical(layoutSize: groupSize22,
                                                      subitems: subItems4)

        
        let groupSize1 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction),
                                                heightDimension: .estimated(40))
        let group1 = NSCollectionLayoutGroup.vertical(layoutSize: groupSize1,
                                                      subitems: [group11, group12])
        
        group1.interItemSpacing = .fixed(5)
        let groupSize2 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction),
                                                heightDimension: .estimated(40))
        let group2 = NSCollectionLayoutGroup.vertical(layoutSize: groupSize2,
                                                      subitems: [group21, group22])
        group2.interItemSpacing = .fixed(5)
    
        // Container Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(40))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [group1, group2])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: inset,
                                                        leading: inset,
                                                        bottom: inset,
                                                        trailing: inset)
        section.interGroupSpacing = 5
        return section
    }
    
    
    lazy var compositionalLayout = UICollectionViewCompositionalLayout(sectionProvider: {
        (sectionIndex, environment) -> NSCollectionLayoutSection? in
        guard environment.traitCollection.horizontalSizeClass != .compact else {
            return self.compactLayout()
        }
        return self.regularLayout(sectionIndex)
    })

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        searchCollectionView.reloadData()
    }
}


extension ViewController2: UICollectionViewDelegate,
                           UICollectionViewDataSource,
                           UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell1",
                                                      for: indexPath) as! MyCollectionViewCell
        if indexPath.item % 2 == 0 {
            cell.text = "sdgsdg"
        } else {
            cell.text = texts[indexPath.item]
        }
        return cell
    }
    
    var texts: [String] {
        return [
            "skjfbskjdfbnsk dfjks kjsd fkljsd fkjsdbnflksdhbfl isdfihsdfoiuhsdof isdhfjfbksjfbskjfb ksjdbfkjsf kjsbdf ks fkjs fkj skfb ksfkj skjfb ksjfbskjfbkjsbfn",
            "sdkfbskdfjbskjdfbskjfbksbfj kjsbd ksdjfbksjbfksjdbfkjsbfksbdfkjbskdjfbskjbfkjsbdfkjsbfkbsljfbsjlfblsbfjlsdbflsblfjbnsljfbnlsjdbfjlbsdljfbsbfjlsbnfbnskjfblsjbfljsbfljsbkfjbsjfbsljfbljsbnfljsbfljsbnljfbnlsjbflbnsljfnljsnflfkjb",
            "kjsbkjsbdfkjsbndfkjnsf kjsbfkjsbfks ksjbf",
            "skjdfbnksbf fksfb ksjbdfksjfb kjsbfkjs fkjsbkfbsjfbjksbfjknsbfjlsfjlnslnf ks fsjkf sjf ks f",
            " kjsbdfkjb  ksjdbfnkjsbnfkjsdbfkjs dkfjbds kjfbnskdjbfkjsdhbfkjsdhfkjshdkfh skjdfbkjsdbfksjbfkjsbdfkjbskdjfbskjdfbkjsbdfkjsbfdkbsdkjfbskjfbksjbdfkjsbkfjbsklfblsdbfljsbfjklsbkjfbskbfkjsbfkjsbfkjbskjfbskjfbsljbfjlsdbfljsbfljsbfkjsbfkjsb",
            " kjsbdfkjb",
            "lskdnflksnflsnflsn f sldkjfnbslkjdfnbslkdflsdfhsoidfhioshfsdilhlskdghklsdhfklsdhflsdhjflisdhflsdihfls flsdhflksdnflksflksdhflsdflksdnflkshflskdflsfnlsdkfnllksnflksnfklsnflknl kjsbdfkjb",
            " kjsb ksdjfbksjdbflsjdbflsjdbfnlsnflsndflksnfl;ksdnflksnklfnsdlkfnslfnlsnfdlknskfdns;kf",
            "sdkfbskdfjbskjdfbskjfbksbf ksjdfbnkjsbnfkjsbfkjlsbdfljsflnnlskdfnlksbflsjbflsbfnl j kjsbdfkjb",
            "gkjcylh;m,gm gcjl,jncnj.kvbjkghigirfkfjdfdiltgfidfkigfigjjfkigvjkfckxldxitkirfkgf kfkgfg kcvmf fkfxdkxdj nhgvnhbhjhj hbjhhj ....IRA......",
            "skjfbskjdfbnsk dfjks kjsd fkljsd fkjsdbnflksdhbfl isdfihsdfoiuhsdof isdhfjfbksjfbskjfb ksjdbfkjsf kjsbdf ks fkjs fkj skfb ksfkj skjfb ksjfbskjfbkjsbfn",
            "sdkfbskdfjbskjdfbskjfbksbfj kjsbd ksdjfbksjbfksjdbfkjsbfksbdfkjbskdjfbskjbfkjsbdfkjsbfkbsljfbsjlfblsbfjlsdbflsblfjbnsljfbnlsjdbfjlbsdljfbsbfjlsbnfbnskjfblsjbfljsbfljsbkfjbsjfbsljfbljsbnfljsbfljsbnljfbnlsjbflbnsljfnljsnflfkjb",
            "kjsbkjsbdfkjsbndfkjnsf kjsbfkjsbfks ksjbf",
            "skjdfbnksbf fksfb ksjbdfksjfb kjsbfkjs fkjsbkfbsjfbjksbfjknsbfjlsfjlnslnf ks fsjkf sjf ks f",
            " kjsbdfkjb  ksjdbfnkjsbnfkjsdbfkjs dkfjbds kjfbnskdjbfkjsdhbfkjsdhfkjshdkfh skjdfbkjsdbfksjbfkjsbdfkjbskdjfbskjdfbkjsbdfkjsbfdkbsdkjfbskjfbksjbdfkjsbkfjbsklfblsdbfljsbfjklsbkjfbskbfkjsbfkjsbfkjbskjfbskjfbsljbfjlsdbfljsbfljsbfkjsbfkjsb",
            " kjsbdfkjb",
            "lskdnflksnflsnflsn f sldkjfnbslkjdfnbslkdflsdfhsoidfhioshfsdilhlskdghklsdhfklsdhflsdhjflisdhflsdihfls flsdhflksdnflksflksdhflsdflksdnflkshflskdflsfnlsdkfnllksnflksnfklsnflknl kjsbdfkjb",
            " kjsb ksdjfbksjdbflsjdbflsjdbfnlsnflsndflksnfl;ksdnflksnklfnsdlkfnslfnlsnfdlknskfdns;kf",
            "sdkfbskdfjbskjdfbskjfbksbf ksjdfbnkjsbnfkjsbfkjlsbdfljsflnnlskdfnlksbflsjbflsbfnl j kjsbdfkjb",
            "gkjcylh;m,gm gcjl,jncnj.kvbjkghigirfkfjdfdiltgfidfkigfigjjfkigvjkfckxldxitkirfkgf kfkgfg kcvmf fkfxdkxdj nhgvnhbhjhj hbjhhj ....IRA......",
            "skjfbskjdfbnsk dfjks kjsd fkljsd fkjsdbnflksdhbfl isdfihsdfoiuhsdof isdhfjfbksjfbskjfb ksjdbfkjsf kjsbdf ks fkjs fkj skfb ksfkj skjfb ksjfbskjfbkjsbfn",
            "sdkfbskdfjbskjdfbskjfbksbfj kjsbd ksdjfbksjbfksjdbfkjsbfksbdfkjbskdjfbskjbfkjsbdfkjsbfkbsljfbsjlfblsbfjlsdbflsblfjbnsljfbnlsjdbfjlbsdljfbsbfjlsbnfbnskjfblsjbfljsbfljsbkfjbsjfbsljfbljsbnfljsbfljsbnljfbnlsjbflbnsljfnljsnflfkjb",
            "kjsbkjsbdfkjsbndfkjnsf kjsbfkjsbfks ksjbf",
            "skjdfbnksbf fksfb ksjbdfksjfb kjsbfkjs fkjsbkfbsjfbjksbfjknsbfjlsfjlnslnf ks fsjkf sjf ks f",
            " kjsbdfkjb  ksjdbfnkjsbnfkjsdbfkjs dkfjbds kjfbnskdjbfkjsdhbfkjsdhfkjshdkfh skjdfbkjsdbfksjbfkjsbdfkjbskdjfbskjdfbkjsbdfkjsbfdkbsdkjfbskjfbksjbdfkjsbkfjbsklfblsdbfljsbfjklsbkjfbskbfkjsbfkjsbfkjbskjfbskjfbsljbfjlsdbfljsbfljsbfkjsbfkjsb",
            " kjsbdfkjb",
            "lskdnflksnflsnflsn f sldkjfnbslkjdfnbslkdflsdfhsoidfhioshfsdilhlskdghklsdhfklsdhflsdhjflisdhflsdihfls flsdhflksdnflksflksdhflsdflksdnflkshflskdflsfnlsdkfnllksnflksnfklsnflknl kjsbdfkjb",
            " kjsb ksdjfbksjdbflsjdbflsjdbfnlsnflsndflksnfl;ksdnflksnklfnsdlkfnslfnlsnfdlknskfdns;kf",
            "sdkfbskdfjbskjdfbskjfbksbf ksjdfbnkjsbnfkjsbfkjlsbdfljsflnnlskdfnlksbflsjbflsbfnl j kjsbdfkjb",
            "gkjcylh;m,gm gcjl,jncnj.kvbjkghigirfkfjdfdiltgfidfkigfigjjfkigvjkfckxldxitkirfkgf kfkgfg kcvmf fkfxdkxdj nhgvnhbhjhj hbjhhj ....IRA......",
            "skjfbskjdfbnsk dfjks kjsd fkljsd fkjsdbnflksdhbfl isdfihsdfoiuhsdof isdhfjfbksjfbskjfb ksjdbfkjsf kjsbdf ks fkjs fkj skfb ksfkj skjfb ksjfbskjfbkjsbfn",
            "sdkfbskdfjbskjdfbskjfbksbfj kjsbd ksdjfbksjbfksjdbfkjsbfksbdfkjbskdjfbskjbfkjsbdfkjsbfkbsljfbsjlfblsbfjlsdbflsblfjbnsljfbnlsjdbfjlbsdljfbsbfjlsbnfbnskjfblsjbfljsbfljsbkfjbsjfbsljfbljsbnfljsbfljsbnljfbnlsjbflbnsljfnljsnflfkjb",
            "kjsbkjsbdfkjsbndfkjnsf kjsbfkjsbfks ksjbf",
            "skjdfbnksbf fksfb ksjbdfksjfb kjsbfkjs fkjsbkfbsjfbjksbfjknsbfjlsfjlnslnf ks fsjkf sjf ks f",
            " kjsbdfkjb  ksjdbfnkjsbnfkjsdbfkjs dkfjbds kjfbnskdjbfkjsdhbfkjsdhfkjshdkfh skjdfbkjsdbfksjbfkjsbdfkjbskdjfbskjdfbkjsbdfkjsbfdkbsdkjfbskjfbksjbdfkjsbkfjbsklfblsdbfljsbfjklsbkjfbskbfkjsbfkjsbfkjbskjfbskjfbsljbfjlsdbfljsbfljsbfkjsbfkjsb",
            " kjsbdfkjb",
            "lskdnflksnflsnflsn f sldkjfnbslkjdfnbslkdflsdfhsoidfhioshfsdilhlskdghklsdhfklsdhflsdhjflisdhflsdihfls flsdhflksdnflksflksdhflsdflksdnflkshflskdflsfnlsdkfnllksnflksnfklsnflknl kjsbdfkjb",
            " kjsb ksdjfbksjdbflsjdbflsjdbfnlsnflsndflksnfl;ksdnflksnklfnsdlkfnslfnlsnfdlknskfdns;kf",
            "sdkfbskdfjbskjdfbskjfbksbf ksjdfbnkjsbnfkjsbfkjlsbdfljsflnnlskdfnlksbflsjbflsbfnl j kjsbdfkjb",
            "gkjcylh;m,gm gcjl,jncnj.kvbjkghigirfkfjdfdiltgfidfkigfigjjfkigvjkfckxldxitkirfkgf kfkgfg kcvmf fkfxdkxdj nhgvnhbhjhj hbjhhj ....IRA......"
        ]
    }
    
    var texts2: [String] {
        return [
           "sdfgsdgsdgsdg",
           "sdgsgsgsdgsdgsg"
        ]
    }
}
