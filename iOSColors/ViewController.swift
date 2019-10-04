//
//  ContentView.swift
//  iOSColors
//
//  Created by Justin Allen on 10/4/19.
//  Copyright © 2019 Justin Allen. All rights reserved.
//

import Foundation
import UIKit

class ToastLabel: UILabel {
    var textInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }

    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: textInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top, left: -textInsets.left, bottom: -textInsets.bottom, right: -textInsets.right)

        return textRect.inset(by: invertedInsets)
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
}

extension UIViewController {
    static let DELAY_SHORT = 1.5
    static let DELAY_LONG = 3.0

    func showToast(_ text: String, delay: TimeInterval = DELAY_LONG) {
        let label = ToastLabel()
        label.backgroundColor = UIColor(white: 0, alpha: 0.5)
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.alpha = 0
        label.text = text
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        label.numberOfLines = 0
        label.textInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        let saveArea = view.safeAreaLayoutGuide
        label.centerXAnchor.constraint(equalTo: saveArea.centerXAnchor, constant: 0).isActive = true
        label.leadingAnchor.constraint(greaterThanOrEqualTo: saveArea.leadingAnchor, constant: 15).isActive = true
        label.trailingAnchor.constraint(lessThanOrEqualTo: saveArea.trailingAnchor, constant: -15).isActive = true
        label.bottomAnchor.constraint(equalTo: saveArea.bottomAnchor, constant: -30).isActive = true

        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            label.alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: delay, options: .curveEaseOut, animations: {
                label.alpha = 0
            }, completion: {_ in
                label.removeFromSuperview()
            })
        })
    }
}

extension UIColor {
    convenience init(r : CGFloat, g: CGFloat, b: CGFloat){
        self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 1)
    }
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red * 255, green * 255, blue * 255, alpha * 255)
    }
}

class ViewController: UITableViewController {
    
    class ColorCellData {
        var name : String?
        var systemColor: UIColor?
        var darkColor : UIColor?
        var lightColor: UIColor?
        init(_ name: String,_ systemColor: UIColor, _ darkColor: UIColor, _ lightColor: UIColor){
            self.name = name
            self.systemColor = systemColor
            self.darkColor = darkColor
            self.lightColor = lightColor
        }
    }
    
    var cellData : [ColorCellData] = []
    
    override func viewDidLoad() {
//        let c = ColorCellData("test", UIColor.blue, UIColor.lightGray)
//        UIColor.label
        cellData.append(ColorCellData("labelColor",UIColor.label, UIColor.black, UIColor.white))
        cellData.append(ColorCellData("secondaryLabelColor", UIColor.secondaryLabel, UIColor.init(r: 255, g: 255, b: 255), UIColor.init(r: 0, g: 0, b: 0)))
        
        cellData.append(ColorCellData("separator", UIColor.separator, UIColor.init(r: 84, g: 84, b: 88), UIColor.init(r: 60, g: 60, b: 67)))
        
        cellData.append(ColorCellData("opaqueSeparator", UIColor.opaqueSeparator, UIColor.init(r: 56, g: 56, b: 58), UIColor.init(r: 198, g: 198, b: 200)))
        
        cellData.append(ColorCellData("link", UIColor.link, UIColor.init(r: 9, g: 132, b: 255), UIColor.init(r: 0, g: 122, b: 255)))
        
        cellData.append(ColorCellData("systemGray", UIColor.systemGray, UIColor.init(r: 142, g: 142, b: 147), UIColor.init(r: 142, g: 142, b: 147)))
        cellData.append(ColorCellData("systemGray2", UIColor.systemGray2, UIColor.init(r: 174, g: 174, b: 178), UIColor.init(r: 99, g: 99, b: 102)))
        cellData.append(ColorCellData("systemGray3", UIColor.systemGray3, UIColor.init(r: 199, g: 199, b: 204), UIColor.init(r: 72, g: 72, b: 74)))
        cellData.append(ColorCellData("systemGray4", UIColor.systemGray4, UIColor.init(r: 209, g: 209, b: 214), UIColor.init(r: 58, g: 58, b: 60)))
        cellData.append(ColorCellData("systemGray5", UIColor.systemGray5, UIColor.init(r: 229, g: 229, b: 234), UIColor.init(r: 44, g: 44, b: 46)))
        cellData.append(ColorCellData("systemGray6", UIColor.systemGray6, UIColor.init(r: 242, g: 242, b: 247), UIColor.init(r: 28, g: 28, b: 30)))
        
        title = "iOS Colors"
        
//        print(UIColor.secondaryLabel.rgba)
//        let colorListName = ["label", "secondaryLabel", "tertiaryLabel", "quaternaryLabel","placeholderText", "placeholderText", "opaqueSeparator", "link"]
//        let colorList = [UIColor.label, UIColor.secondaryLabel, UIColor.tertiaryLabel, UIColor.quaternaryLabel, UIColor.placeholderText, UIColor.separator, UIColor.opaqueSeparator, UIColor.link]
//        for (index, color) in colorList.enumerated() {
////            print(color.rgba)
//            let col = color.rgba
////            let str = String(format: "%@, R:%.0f, G:%.0f, B:%.0f,", colorListName[index], col.red, col.green, col.blue)
//            
//            let str = String(format: "%@,%.0f,%.0f,%.0f,", colorListName[index], col.red, col.green, col.blue)
//            print(str)
//        }
        
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableCell(style: .default, reuseIdentifier: "Cell1")
        cell.label.text = cellData[indexPath.row].name!
        
        let col = cellData[indexPath.row].systemColor?.rgba
        let str = String(format: "R:%.0f, G:%.0f, B:%.0f", col!.red, col!.green, col!.blue)
        cell.RGBlabel.text = str
        
        let rgb:Int = (Int)(col!.red)<<16 | (Int)(col!.green)<<8 | (Int)(col!.blue)<<0
        cell.HEXlabel.text = String(format:"HEX: #%06x", rgb)
        
        cell.currentBox.backgroundColor = cellData[indexPath.row].systemColor!
        cell.darkBox.backgroundColor = cellData[indexPath.row].darkColor!
        cell.lightBox.backgroundColor = cellData[indexPath.row].lightColor!
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        print(cellData[indexPath.row].systemColor?.rgba as Any)
//        let col = cellData[indexPath.row].systemColor?.rgba
//        let str = String(format: "R:%.0f, G:%.0f, B:%.0f", col!.red, col!.green, col!.blue)
//        showToast(str)
    }
    
    class TableCell: UITableViewCell {
        
        let label : UILabel = {
            let l = UILabel()
            l.textAlignment = .left
            l.font = UIFont(name: "Times New Roman", size: 25)
            return l
        }()
        
        let RGBlabel : UILabel = {
            let l = UILabel()
            l.textAlignment = .left
            l.text = "RGB"
            l.font = UIFont(name: "Times New Roman", size: 18)
            return l
        }()
        
        let HEXlabel : UILabel = {
            let l = UILabel()
            l.textAlignment = .left
            l.text = "RGB"
            l.font = UIFont(name: "Times New Roman", size: 18)
            return l
        }()
        
        let currentBox: UIView = {
            let box = UIView()
            box.heightAnchor.constraint(equalToConstant: 80).isActive = true
            box.widthAnchor.constraint(equalToConstant: 80).isActive = true
            return box
        }()
        
        let currentBoxLabel : UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.text = "current"
            label.font = UIFont(name: "Times New Roman", size: 9)
            return label
        }()
        
        let darkBox : UIView = {
            let box = UIView()
            box.heightAnchor.constraint(equalToConstant: 80).isActive = true
            box.widthAnchor.constraint(equalToConstant: 80).isActive = true
            return box
        }()
        
        let darkBoxLabel : UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.text = "dark"
            label.font = UIFont(name: "Times New Roman", size: 9)
            return label
        }()
        
        let lightBox : UIView = {
            let box = UIView()
            box.heightAnchor.constraint(equalToConstant: 80).isActive = true
            box.widthAnchor.constraint(equalToConstant: 80).isActive = true
            return box
        }()
        
        let lightBoxLabel : UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.text = "light"
            label.font = UIFont(name: "Times New Roman", size: 9)
            return label
        }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)

            let currentBoxStack = UIStackView(arrangedSubviews: [currentBox, currentBoxLabel])
            currentBoxStack.axis = .vertical
            
            let lightBoxStack = UIStackView(arrangedSubviews: [lightBox, lightBoxLabel])
            lightBoxStack.axis = .vertical
            
            let darkboxStack = UIStackView(arrangedSubviews: [darkBox, darkBoxLabel])
            darkboxStack.axis = .vertical
            
            let labelStack = UIStackView(arrangedSubviews: [label/*, RGBlabel, HEXlabel*/])
            labelStack.axis = .vertical
            
            let cellStack = UIStackView(arrangedSubviews: [labelStack, /*currentBoxStack, */lightBoxStack, darkboxStack])
            cellStack.axis = .horizontal
            
            addSubview(cellStack)
            let _ = Utils.SetupContrains(child: cellStack, parent: safeAreaLayoutGuide)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
