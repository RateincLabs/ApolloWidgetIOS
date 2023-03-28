## Instalación
---

Configuración de la libreria:

```ruby
# Podfile

target 'example' do

    use_frameworks!

    pod 'ApolloWidget', :git => 'https://github.com/RateincLabs/ApolloWidgetIOS', :tag => '0.4.4-prod' # el pod principal
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
La clase Apollo cuenta con tres inputs:
* controller: controlador que invoca a la encuesta
* surveyID: Identificador de la encuesta
* apolloDelegate: Necesario para el uso de protocols

```swift
let apolloTest = ApolloWidgetSetup(controller: self, surveyID: "YWxjby9wcmltZXJhLXBydWViYS1wdWJsaWNhLWRlbC13aWRnZXQ=", apolloDelegate: self)
```

Para agregar Extras existen dos formas:

```swift
// Add extras individually
apolloTest.addExtras(key: "session_client_id", value: "id_de_cliente")
apolloTest.addExtras(key: "o_1025", value: "Banco Demo")
apolloTest.addExtras(key: "o_1104", value: "khipu")
apolloTest.addExtras(key: "o_1103", value: "iOS")
apolloTest.addExtras(key: "o_1011", value: "999")

// Add extras with populated array [string:string]
let extrasArray: [String: String] = [
    "session_client_id": "id_de_cliente",
    "o_1025":"Banco Demo",
    "o_1104": "khipu",
    "o_1103": "iOS",
    "o_1011": "999",
    "o_777": "daniel.s"
];

apolloTest.addExtrasArray(e: extrasArray)
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

extra:

Para realizar configuraciones más avanzadas del widget, es posible acceder al controller y realizar ajustes usando el método getApolloWidgetControllerInstance()

```swift
let apolloTest = ApolloWidgetSetup(controller: self, surveyID: "YxxWxjby9wcmltZXJhLXBydWViYS1wdWJsaWNhLWRlbC13aWRnZXQ=", apolloDelegate: self)

apolloTest.getApolloWidgetControllerInstance().presentationController?.delegate = self

```

&nbsp;
## App ejemplo de inicialización
---

```swift
import UIKit
import ApolloWidget // el pod principal
import UIDrawer // es necesario para desplegar en versiones iOS < 15

class ViewController: UIViewController, ApolloWidgetProtocol {
    func apolloSurveyHasBeenWarned(status: Int, message: String) {
        // code
    }
    
    func apolloSurveyHasbeenDismissed(status: Int, message: String) {
        // code
    }
    
    func apolloSurveyHasBeenAnswered(status: Int, message: String) {
        // code
    }
    
    func apolloSurveyHasBeenClosedUsingTheButton(status: Int, message: String) {
        // code
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let apolloTest = ApolloWidgetSetup(controller: self, surveyID: "YxxWxjby9wcmltZXJhLXBydWViYS1wdWJsaWNhLWRlbC13aWRnZXQ=", apolloDelegate: self)
        
        // Add extras individually
        apolloTest.addExtras(key: "session_client_id", value: "id_de_cliente")
        apolloTest.addExtras(key: "o_1025", value: "Banco Demo")
        apolloTest.addExtras(key: "o_1104", value: "khipu")
        apolloTest.addExtras(key: "o_1103", value: "iOS")
        apolloTest.addExtras(key: "o_1011", value: "999")

        // Add extras with populated array [string:string]
        let extrasArray: [String: String] = [
            "session_client_id": "id_de_cliente",
            "o_1025":"Banco Demo",
            "o_1104": "khipu",
            "o_1103": "iOS",
            "o_1011": "999",
            "o_777": "daniel.s"
        ];

        apolloTest.addExtrasArray(e: extrasArray)

        // Access to apolloWidgetController for advanced configurations
        apolloTest.getApolloWidgetControllerInstance().presentationController?.delegate = self

        apolloTest.run()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// esto es necesario después de la clase donde se llame a la librería
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
