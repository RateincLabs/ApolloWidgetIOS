## Instalación
---

Configuración de la libreria:

```ruby
# Podfile

target 'example' do

    use_frameworks!

    pod 'ApolloWidget', '0.1.0' # el pod principal
    pod 'UIDrawer', :git => 'https://github.com/pckz/UIDrawer.git', :tag => '1.0' # es requisito de ApolloWidget para desplegar en versiones iOS < 15

end
```

Agregando la librería al código:

```swift
import ApolloWidget
import UIDrawer
```

Ambos import son necesarios

## Uso de la clase Apollo
---
La clase Apollo cuenta con dos inputs:
* controller: controlador que invoca a la encuesta
* surveyID: Identificador de la encuesta

```swift
let apolloTest = ApolloWidgetSetup(controller: self, surveyID: "YWxjby9wcmltZXJhLXBydWViYS1wdWJsaWNhLWRlbC13aWRnZXQ=")
```

Para agregar Extras se debe utilizar el metodo addExtras:

```swift
apolloTest.addExtras(key: "session_client_id", value: "test100")
```

Para iniciar la encuesta se debe utilizar el metodo run:

```swift
apolloTest.run()
```

Después de que termina el código de la clase donde se llama a ApolloWidgetSetup(controller, surveyID), se debe agregar el siguiente extends

```swift
extension ViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = DrawerPresentationController(presentedViewController: presented, presenting: presenting)
        return DrawerPresentationController(presentedViewController: presented, presenting: presenting, blurEffectStyle: .light)
    }
}
```

&nbsp;
## App ejemplo de inicialización
---

```swift
import UIKit
import ApolloWidget // el pod principal
import UIDrawer // es necesario para desplegar en versiones iOS < 15

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let apolloTest = ApolloWidgetSetup(controller: self, surveyID: "YWxjby9wcmltZXJhLXBydWViYS1wdWJsaWNhLWRlbC13aWRnZXQ=")
        
        apolloTest.addExtras(key: "session_client_id", value: "test100")
        
        apolloTest.run()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = DrawerPresentationController(presentedViewController: presented, presenting: presenting)
        return DrawerPresentationController(presentedViewController: presented, presenting: presenting, blurEffectStyle: .light)
    }
}
```

Importante: el extension es necesario ya que sobreescribe el transitioning delegate que será utilizado por UIDrawer, necesario para iOS < 15. El pod principal de ApolloWidget comprueba la versión de iOS y muestra dependiendo el caso:
    >= iOS 15: utiliza el método sheetPresentationController para hacer la presentación del modal
    < iOS 15: utiliza UIDrawer para hacer la presentación del modal