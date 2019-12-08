Cours 1
====

### Auteurs du CR
Zhi Zhou, <zhi.zhou@ensta-paris.fr>
 Simon Queyrut,  <simon.queyrut@ensta-paris.fr>
 
 [@zroykhi](https://github.com/zroykhi), [@queyrusi][github] 

[github]: http://github.com/queyrusi

Résumé de cours
----
Un **robot mobile** doit assurer son **autonomie** pour accomplir sa mission. On pose pour cela un **modèle cinématique direct** de ses articulations (pour un unicycle, tricycle etc.) associé à un repère qui vont permettre entre autres trois applications de son **contrôle**. Elles peuvent faire appel à un **régulateur PID** **réglable** dont chaque composante représente avantages  et inconvénients. L'**asservissement en boucle fermée** requiert un **retour d'état** pour calculer l'erreur à la consigne.

Description du TP
---
Sous Matlab, nous modélisons cinématiquement quatre problèmes de robots mobiles :
1. Unicycle vers une position
2. Bicyclette vers un point 
3. Bicyclette vers une position
4. Suivi de trajectoire par une bicyclette

et simulons les missions grâce aux fichiers fournis. Nous réglons les gains `K_i` des régulateurs P afin de minimiser les erreurs de parcours dans l'atteinte des objectifs.

Résultats
----
Les scores sont ceux du benchmark fourni dans le dossier TP (Mean Goal Reaching Time)
1. **Question 1** : Nous réglons les gains *à tâtons* avec la méthode de Ziegler-Nichols


| `K_rho`  | `K_alpha` | `k_beta` | Score|
| :---------: |:---------:| :-----:| :-----:|
|  20,7 | 6,9 | 22,7 |3182,7|

![](https://markdown.data-ensta.fr/uploads/upload_e128edf1c60bb7365ac52c850d2cd88f.png)


2. **Question 2**

| `K_rho`  | `K_alpha` | Score|
| :---------: |:---------:| :-----:|
|  70.2 | 4.44 |1840|

![](https://markdown.data-ensta.fr/uploads/upload_c6ce2b9b92563f76e752f79ccb75d25f.png)


3. **Question 3** : Le problème est plus compliqué car le robot doit faire une manœuvre pour arriver à la position désirée. Nous faisons comme dans la question 1 un disjonction de cas selon la distance (une voiture ne se gare pas avec les même précautions qu'elle ne se rend au parking)

4. **Question 4**
![](https://markdown.data-ensta.fr/uploads/upload_fb885fcf939f0b3a07af15416d176e06.png)


