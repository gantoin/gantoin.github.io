title=Principe de responsabilité unique (SOLID)
date=2023-09-07T09:09:55Z
type=post
tags=solid, java, architecture
status=published

~~~~~~

Le principe de responsabilité unique (SRP) est le premier principe de SOLID. Il a été introduit par Robert C. Martin en 2003 dans son livre Agile Software Development, Principles, Patterns, and Practices.

J'aimerais revenir dessus car je pense qu'il est très important de le comprendre et de l'appliquer.

## Que sont les principes SOLID ?

Les principes SOLID sont un ensemble de principes de conception logicielle qui permettent de créer des logiciels plus maintenables, flexibles et évolutifs.
Il ne s'agit pas de framework ou de bibliothèque, mais de principes qui peuvent être appliqués dans n'importe quel langage de programmation (pour du développement orienté objet POO/OOP). C'est pourquoi il parfois difficle de mesurer la "solidité" d'un code.

Le principal avantage de ces principes est qu'ils permettent de détecter et corriger de potentiels erreurs d'architecture ou de "code smell" dans une application.

## Qu'est-ce que le principe de responsabilité unique ?

Le principe de responsabilité unique conciste à dire qu'une classe, une méthode, un service ne doit avoir qu'une seule "responsabilité".

**"Do one thing and do it well"**

Par exemple :

```java
public class CoffeeMaker {
    public void makeCoffee() {
        // ...
    }
}
```

Cette classe a une seule responsabilité : faire du café.
Sa méthode `makeCoffee()` a une seule responsabilité : faire du café.

```java
public class CoffeeMaker {
    public void makeCoffee() {
        grindBeans();
        boilWater();
        pourWater();
    }
    private void grindBeans() {
        // ... 
    }
    private void boilWater() {
        // ... 
    }
    private void pourWater() {
        // ...
    }
}
```

On peut ajouter de la granularité à la méthode `makeCofee` pour respecter le SRP en créant des méthodes privées.
Chaque méthode a sa propre responsabilité. Ici, `grindBeans()` a la responsabilité de moudre les grains de café, `boilWater()` a la responsabilité de faire bouillir l'eau et `pourWater()` a la responsabilité de verser l'eau.

C'est un exemple très simple, mais il est important de comprendre que le SRP peut être appliqué à n'importe quelle classe, méthode ou service.

## Pourquoi le principe de responsabilité unique est-il important ?

Le SRP est important car il permet de créer des classes, méthodes, services plus maintenables, flexibles et évolutifs.

Pour respecter ce principe, il est important de comprendre qu'une méthode ne doit concerner qu'un seul niveau d'abstraction. Par exemple, une méthode qui fait à la fois de la logique métier et de la logique technique ne respecte pas le SRP.

On appelle cela le "Single Level of Abstraction Principle" (SLAP).
Un niveau d'abstraction est un niveau de détail dans une méthode. Par exemple, une méthode qui fait à la fois un appel à une API et une requête à une base de données ne respecte pas le SLAP.

La décomposition d'un code qui respecte le SRP vous permettra de mieux ajouté de nouvelles fonctionnalités, de mieux le tester et de mieux le maintenir.

## Conclusion

Le SRP est le principe le plus simple à comprendre et à appliquer. Vous l'appliquez probablement déjà sans le savoir.

Si vous avez des doutes sur une méthode, une classe ou un service, demandez-vous si il a bien une seule responsabilité : que fait ce bout de code ? Est-ce qu'il fait plus d'une chose ? Si oui, il ne respecte surement xpas le SRP.

## Aller plus loin

[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/zHiWqnTWsn4/0.jpg)](https://www.youtube.com/watch?v=zHiWqnTWsn4)
Uncle Bob - The SOLID Principles
