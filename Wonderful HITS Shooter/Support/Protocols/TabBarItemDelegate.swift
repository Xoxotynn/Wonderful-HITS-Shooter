protocol TabBarItemDelegate: AnyObject {
    func configureTitleView(withPoints points: Int)
    func configureTitleView(withMoney money: Int)
}
