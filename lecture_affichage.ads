--sp�cification du paquetage lecture_affichage.ads

with sous_prog01; use sous_prog01;

package lecture_affichage is

   --lit le nom d'une mati�re et son coeffecient associ� et les stockent dans
   --la case 'i' d'un tableau de mati�res 'matieres'
   procedure lire( matieres : in out TabMatieres; i : in Natural);



end lecture_affichage;
