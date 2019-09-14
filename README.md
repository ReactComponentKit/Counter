# Counter

This is [ReactComponentKit](https://github.com/ReactComponentKit/ReactComponentKit) example. Counter is very simple and basic redux example. 

## Screenshot

![](art/counter.png)

## What is ReactComponentKit

ReactComponentKit is a library for building a UIViewController based on Component. Additionary, It architect UIViewController as Redux with MVVM. If you use ReactComponentKit, You can make many scenes(UIViewController) more easily. You can share components among scenes. 

## Define Components

### CountLabelComponent

```swift
import Foundation
import ReactComponentKit
import SnapKit

protocol CountLabelComponentState {
    var count: Int { get }
}

class CountLabelComponent: UIViewComponent {
    
    private lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textColor = UIColor.black
        label.text = "0"
        label.textAlignment = .center
        return label
    }()
    
    override var contentSize: CGSize {
        return label.intrinsicContentSize
    }
    
    override func setupView() {
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        // subscribe new state. The new state is dispatched to here when it updated.
        subscribeState()
    }
        
    override func on(state: State) {
        guard let countState = state as? CountLabelComponentState else { return }
        label.text = String(countState.count)
    }
}
```

UIViewComponent is just a UIView. You can layout sub views or components in the setupView method by using SnapKit. ReactComponentKit uses SnapKit to layout views. 

### IncrementButtonComponent & DecrementButtonComponent

```swift
import ReactComponentKit
import RxSwift
import RxCocoa

class IncrementButtonComponent: UIViewComponent {
    
    var onTap: (() -> Void)? = nil
    
    private let disposeBag = DisposeBag()
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.frame = .zero
        button.setTitle("+", for: [])
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)

        button
            .rx.tap
            .subscribe(onNext: { [weak self] in
                self?.onTap?()
            }).disposed(by: disposeBag)
            
        
        return button
    }()
    
    override func setupView() {
        addSubview(button)
        button.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
```

```swift
import ReactComponentKit
import RxSwift
import RxCocoa

class DecrementButtonComponent: UIViewComponent {
    
    var onTap: (() -> Void)? = nil
    
    private let disposeBag = DisposeBag()
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.frame = .zero
        button.setTitle("-", for: [])
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        
        button
            .rx.tap
            .subscribe(onNext: { [weak self] in
                self?.onTap?()
            }).disposed(by: disposeBag)
        
        return button
    }()
    
    override func setupView() {
        addSubview(button)
        button.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
```

You can make above button components more general like as ActionButtonComponent. However, I made button components separately. 

## Define Reducers in viewModel

```swift
...

func increase(count: Int) {
	setState {
		$0.copy { $0.count += count }
	}
}
    
func decrease(count: Int) {
	setState {
		$0.copy { $0.count -= count }
	}
}

...
```


## Define ViewModel & State

```swift
import Foundation
import ReactComponentKit

struct CounterState: State, CountLabelComponentState {
    var count: Int = 0
    var error: RCKError? = nil
}

class CounterViewModel: RCKViewModel<CounterState> {
    
    override func setupStore() {
        initStore { store in
            store.initial(state: CounterState())
        }
    }
    
    func increase(count: Int) {
         setState {
            $0.copy { $0.count += count }
        }
    }
    
    func decrease(count: Int) {
        setState {
            $0.copy { $0.count -= count }
        }
    }
}
```

RootViewModelType has a redux stroe. You can define state.

## Using Reducers

```swift

...

incrementButton.onTap = { [weak self] in
	guard let strongSelf = self else { return }
	strongSelf.viewModel.increase(count: 1)
}
    
decrementButton.onTap = { [weak self] in
	guard let strongSelf = self else { return }
	strongSelf.viewModel.decrease(count: 1)
}

...

```

## Make Scene(UIViewController)

```swift
import UIKit
import ReactComponentKit

class CounterViewController: UIViewController {
    
    private lazy var viewModel: CounterViewModel = {
        return CounterViewModel()
    }()
    
    private lazy var countLabel: CountLabelComponent = {
        return CountLabelComponent(token: viewModel.token)
    }()
    
    private lazy var incrementButton: IncrementButtonComponent = {
        return IncrementButtonComponent(token: viewModel.token)
    }()
    
    private lazy var decrementButton: DecrementButtonComponent = {
        return DecrementButtonComponent(token: viewModel.token)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(countLabel)
        view.addSubview(incrementButton)
        view.addSubview(decrementButton)
        
        countLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        decrementButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalTo(48)
        }
        
        incrementButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalTo(48)
        }
        
        incrementButton.onTap = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.viewModel.increase(count: 1)
        }
        
        decrementButton.onTap = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.viewModel.decrease(count: 1)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
```

## MIT License

The MIT License

Copyright © 2018 Sungcheol Kim, https://github.com/ReactComponentKit/Counter

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.