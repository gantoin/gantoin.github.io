title=Principe de substitution de Liskov (SOLID)
date=2023-09-11T08:39:25Z
type=post
tags=solid, java, architecture
status=published

~~~~~~

Le principe de substitution de Liskov (LSP) est le troisième principe de SOLID. Il a été introduit par Barbara Liskov en 1987 dans son article Data abstraction and hierarchy.

## Que sont les principes SOLID ?

Les principes SOLID sont un ensemble de principes de conception logicielle qui permettent de créer des logiciels plus maintenables, flexibles et évolutifs.

Il ne s'agit pas de framework ou de bibliothèque, mais de principes qui peuvent être appliqués dans n'importe quel langage de programmation (pour du développement orienté objet POO/OOP). C'est pourquoi il parfois difficle de mesurer la "solidité" d'un code.

Le principal avantage de ces principes est qu'ils permettent de détecter et corriger de potentiels erreurs d'architecture ou de "code smell" dans une application.

## Qu'est-ce que le principe de substitution de Liskov ?

Le principe de substitution de Liskov conciste à dire qu'une classe fille doit pouvoir être substituée à sa classe mère sans altérer le bon fonctionnement du programme.

On parle d'alteration fu programme si le comportement du programme est inattendu ou si une exception est levée.

Par exemple, voici une classe parente, Rectangle.java :

```java
class Rectangle {
    private int width;
    private int height;
    public Rectangle(int width, int height) {
        this.width = width;
        this.height = height;
    }
    public int getWidth() {
        return width;
    }
    public int getHeight() {
        return height;
    }
    public void setWidth(int width) {
        this.width = width;
    }
    public void setHeight(int height) {
        this.height = height;
    }
    public int getArea() {
        return width * height;
    }
}
```

Et voici une classe fille, Square.java :

```java
class Square extends Rectangle {
    public Square(int side) {
        super(side, side);
    }
    @Override
    public void setWidth(int width) {
        super.setWidth(width);
        super.setHeight(width);
    }
    @Override
    public void setHeight(int height) {
        super.setWidth(height);
        super.setHeight(height);
    }
}
```

On peut voir que la classe Square étend la classe Rectangle. C'est-à-dire que la classe Square hérite de la classe Rectangle.

La classe Square a une seule responsabilité : représenter un carré.

Est-ce que ma classe Carré peut remplacer complètement ma classe Rectangle ? Non.

Un comportement inattendu si on set la largeur, ce sont la largeur et la hauteur qui sont modifiées. C'est un comportement inattendu car on s'attend à ce que la largeur et la hauteur soient indépendantes.

Ce code ne respecte pas le LSP (principe de substitution de Liskov).

On peut facilement détecter un comportement inattendu si notre code contient des méthodes vides, des vérifications de type, un durcissement des conditions ou des exceptions lancées dans tous les sens.

Les relations entre les classes doivent être cohérentes d'un point de vue logiciel et non d'un point de vue métier (du monde réel).
Les relations du monde réel ne correspondent pas forcément avec les relations du programme :

Par exemple :

```java
class Bird {
    public void fly() {
        // ...
    }
}

class Duck extends Bird {
    public void quack() {
        // ...
    }
}
```

Dans le monde réel, un canard est un oiseau. Mais dans le programme, un canard n'est pas un oiseau car il ne peut pas voler.

## Conclusion

Le principe de substitution de Liskov permet d'interchanger les enfants d’une classe sans que cela ait d’incidence sur l'exécution du code.
