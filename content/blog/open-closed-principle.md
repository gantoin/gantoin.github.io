title=Principe ouvert/fermé (SOLID)
date=2023-09-08T09:10:25Z
type=post
tags=solid, java, architecture
status=published

~~~~~~

Le principe ouvert/fermé (OCP) est le deuxième principe de SOLID. Il a été introduit par Bertrand Meyer en 1988 dans son livre Object Oriented Software Construction.

J'aimerais revenir dessus car je pense qu'il est très important de le comprendre et de l'appliquer.

## Que sont les principes SOLID ?

Les principes SOLID sont un ensemble de principes de conception logicielle qui permettent de créer des logiciels plus maintenables, flexibles et évolutifs.

Il ne s'agit pas de framework ou de bibliothèque, mais de principes qui peuvent être appliqués dans n'importe quel langage de programmation (pour du développement orienté objet POO/OOP). C'est pourquoi il parfois difficle de mesurer la "solidité" d'un code.

Le principal avantage de ces principes est qu'ils permettent de détecter et corriger de potentiels erreurs d'architecture ou de "code smell" dans une application.

## Qu'est-ce que le principe ouvert/fermé ?

Le principe ouvert/fermé conciste à dire qu'une classe, une méthode, un service doit être ouvert à l'extension mais fermé à la modification.

C'est-à-dire qu'il doit être possible d'étendre le comportement d'une classe sans la modifier.

Par exemple :

```java
class Square() {
    private int side;
    public Square(int side) {
        this.side = side;
    }
    public int getSide() {
        return side;
    }
}
```

Cette classe représente un carré. Elle a une seule responsabilité : représenter un carré.

Si on souhaite ajouter une méthode pour calculer l'aire du carré, on peut le faire sans modifier la classe :

```java
class Square() {
    private int side;
    public Square(int side) {
        this.side = side;
    }
    public int getSide() {
        return side;
    }
    public int getArea() {
        return side * side;
    }
}
```

On a étendu le comportement de la classe sans la modifier.

On peut aussi étendre le comportement de la classe en créant une classe fille :

```java
class Square() {
    private int side;
    public Square(int side) {
        this.side = side;
    }
    public int getSide() {
        return side;
    }
}

class BigSquare extends Square {
    public BigSquare(int side) {
        super(side);
    }
    public int getArea() {
        return getSide() * getSide();
    }
}
```

Les solutions pour appliquer le principe OCP sont souvent l'héritage ou le Strategy Pattern.

## Le Strategy Pattern

Le Strategy Pattern est un design pattern qui permet de définir une famille d'algorithmes, d'encapsuler chacun d'eux et de les rendre interchangeables.

Par exemple :

![](https://upload.wikimedia.org/wikipedia/commons/3/39/Strategy_Pattern_in_UML.png)

On peut voir que la classe `Context` utilise une interface `Strategy` pour définir une famille d'algorithmes. La classe `Context` peut utiliser n'importe quelle classe qui implémente l'interface `Strategy`.

## Pourquoi le principe ouvert/fermé est-il important ?

Le principe ouvert/fermé est important car il permet de créer des classes, méthodes, services plus maintenables, flexibles et évolutifs.

Si on ne respecte pas ce principe, on risque de devoir modifier une classe existante pour ajouter une nouvelle fonctionnalité. Cela peut être problématique si cette classe est utilisée dans plusieurs endroits de l'application.

Par exemple, si on souhaite ajouter une méthode `getArea()` à la classe `Square`, on devra modifier cette classe. Si cette classe est utilisée dans plusieurs endroits de l'application, on devra modifier ces endroits pour ajouter la méthode `getArea()`.

Si on respecte le principe ouvert/fermé, on pourra étendre le comportement de la classe `Square` sans la modifier.

## Conclusion

Le principe ouvert/fermé est un principe très important à comprendre et à appliquer. Il permet de créer des classes, méthodes, services plus maintenables, flexibles et évolutifs.

Il est important de comprendre que ce principe peut être appliqué à n'importe quelle classe, méthode ou service.

## Aller plus loin

- [Le principe ouvert/fermé sur Wikipedia](https://fr.wikipedia.org/wiki/Principe_ouvert/ferm%C3%A9)
- [Le principe ouvert/fermé sur le site de Robert C. Martin](https://blog.cleancoder.com/uncle-bob/2014/05/12/TheOpenClosedPrinciple.html)
