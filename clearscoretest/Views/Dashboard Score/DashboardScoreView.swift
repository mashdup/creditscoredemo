//
//  DashboardScoreView.swift
//  clearscoretest
//
//  Created by Dillon Hoa on 19/12/2021.
//

import UIKit

class DashboardScoreView: UIView {
    
    weak var viewModel: DashboardViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    lazy var progressView: ProgressView = {
        let p = ProgressView()
        p.translatesAutoresizingMaskIntoConstraints = false
        return p
    }()
    
    private lazy var stackView: UIStackView = {
        let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .vertical
        s.alignment = .center
        s.distribution = .fill
        s.spacing = 8
        s.alpha = 0
        return s
    }()
    
    private lazy var creditTitleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "DASHBOARD_CREDIT_TITLE".localised()
        l.font = .preferredFont(forTextStyle: .body)
        l.textColor = .primaryFont
        l.adjustsFontForContentSizeCategory = true
        return l
    }()
    
    private lazy var scoreLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "327"
        l.font = .systemFont(ofSize: 64, weight: .light)
        l.adjustsFontForContentSizeCategory = true
        l.textColor = .primaryFont
        return l
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "DASHBOARD_OUT_OF".localised()
        l.font = .preferredFont(forTextStyle: .body)
        l.adjustsFontForContentSizeCategory = true
        l.textColor = .primaryFont
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width/2
        layer.borderColor = UIColor.primaryFont.cgColor
    }
    
    func setup() {
        layer.borderWidth = 2
        
        addSubview(progressView)
        addSubview(stackView)
        
        stackView.addArrangedSubview(creditTitleLabel)
        stackView.addArrangedSubview(scoreLabel)
        stackView.addArrangedSubview(subtitleLabel)
        
        progressView.pinToParentView(UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        stackView.pinToParentCenter()
        
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor),
            stackView.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor)
        ])
    }
    
    func bindViewModel() {
        guard let viewModel = viewModel else { return }

        viewModel.$dashboard.sink(receiveValue: { [weak self] updatedDateboard in
            guard let updatedDateboard = updatedDateboard,
                  let score = updatedDateboard.creditReportInfo?.score,
                  let max = updatedDateboard.creditReportInfo?.maxScoreValue else { return }
            DispatchQueue.main.async {
                self?.subtitleLabel.text = "DASHBOARD_OUT_OF".localised() + " \(max)"
                self?.scoreLabel.text = "\(score)"
                if self?.stackView.alpha == 0 {
                    UIView.animate(withDuration: 0.3, animations: {
                        self?.stackView.alpha = 1
                    })
                }
                self?.progressView.setProgress(CGFloat(score)/CGFloat(max))
            }
        }).store(in: &viewModel.subscribers)
    }
}
