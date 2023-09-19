title=Principe de ségrégation des interfaces (SOLID)
date=2023-09-19T09:40:00Z
type=post
tags=solid, java, architecture
status=published

~~~~~~

Le principe de ségrégation des interfaces (ISP) est le quatrième principe de SOLID. Il a été introduit par Robert C. Martin en 1996 dans son article Designing Object Oriented C++ Applications Using the Booch Method.

## Qu'est-ce que le principe de ségrégation des interfaces ?

Le principe de ségrégation des interfaces conciste à dire qu'une classe ne doit pas être forcée d'implémenter une méthode dont elle n'a pas besoin.

"Clients should not be forced to depend on methods that they do not use" - Robert C. Martin

Par exemple, voici une interface, Machine.java :

```java
interface Machine {
    void print(Document d);
    void fax(Document d);
    void scan(Document d);
}
```

Et voici une classe qui implémente cette interface, MultiFunctionPrinter.java :

```java
class MultiFunctionPrinter implements Machine {
    @Override
    public void print(Document d) {
        //
    }
    @Override
    public void fax(Document d) {
        //
    }
    @Override
    public void scan(Document d) {
        //
    }
}
```

Cette classe implémente les trois méthodes de l'interface Machine, mais elle n'a pas besoin de la méthode fax(Document d). Elle est donc forcée d'implémenter une méthode dont elle n'a pas besoin.

Pour résoudre ce problème, il faut séparer l'interface Machine en trois interfaces plus petites, Printer.java, Scanner.java et Fax.java :

```java
interface Printer {
    void print(Document d);
}
interface Scanner {
    void scan(Document d);
}
interface Fax {
    void fax(Document d);
}
```

Et voici une classe qui implémente ces trois interfaces, OldFashionedPrinter.java :

```java
class OldFashionedPrinter implements Printer, Scanner, Fax {
    @Override
    public void print(Document d) {
        //
    }
    @Override
    public void scan(Document d) {
        //
    }
    @Override
    public void fax(Document d) {
        //
    }
}
```

Cette classe implémente les trois interfaces Printer, Scanner et Fax, mais elle n'est pas forcée d'implémenter des méthodes dont elle n'a pas besoin.

## Pourquoi le principe de ségrégation des interfaces est-il important ?

Ce principe vous force à créer des interfaces qui doivent rester petites, pour que les classes qui les implémentent puissent les remplacer à 100%.

Cela permet de minimiser les dépendances entre les classes, et donc de rendre le code plus ciblé sur ce qu'il doit faire.

## Conclusion

Si vous devez implémenter des méthodes dont vous n'avez pas besoin, c'est que votre interface est trop grosse. Votre application ne respecte probablement pas le principe de ségrégation des interfaces.

Vous devrez fragmenter votre interface en plusieurs interfaces plus petites, pour que les classes qui les implémentent puissent les remplacer à 100%.

## Aller plus loin

- [SOLID (object-oriented design) - Wikipedia](https://en.wikipedia.org/wiki/SOLID)
- [SOLID: The First 5 Principles of Object Oriented Design - YouTube](https://www.youtube.com/watch?v=rtmFCcjEgEw)
- [SOLID Principles of Object-Oriented Design Explained with Examples](https://stackify.com/solid-design-principles/)
- [SOLID Design Principles Explained: The Interface Segregation Principle with Code Examples](https://stackify.com/interface-segregation-principle/)
