--spécification du paquetage lecture_affichage.ads

with sous_prog01; use sous_prog01;

package lecture_affichage is

   --lit le nom d'une matière et son coeffecient associé et les stockent dans
   --la case 'i' d'un tableau de matières 'matieres'
   procedure lire( matieres : in out TabMatieres; i : in Natural);



end lecture_affichage;
