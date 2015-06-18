--sp�cification de paquetage sous_prog01.ads

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package sous_prog01 is

   MAX_MATIERES : constant Natural := 6; --nombre maximum de mati�res �tudi�es
   MAX_ELEVES   : constant Natural := 100; --nombre maximum d'�l�ves

   --d�finition d'un ensemble de notes de type TabNotes d�finie par
   --un tableau d'entiers naturels
   type TabNotes is array (1 .. MAX_MATIERES) of Natural;

   --d�finition d'un type Matiere caract�ris� par un nom 'nom',
   --d'un coefficient 'coeff' appliqu� aux notes de cette mati�re
   --et d'une moyenne g�n�rale de la classe � cette mati�re
   type Matiere is record
      nom   : Unbounded_String;
      coeff : Natural;
      moyenne : Float;
   end record;

   --d�finition d'un type Eleve caracti�ris� par un nom 'nom', un ensemble de
   --notes 'notes', une moyenne g�n�rale 'moyenne' et un nombre d'absences
   --justifi�es 'nbAbsence'
   type Eleve is record
      nom     : Unbounded_String;
      notes   : TabNotes;
      moyenne : Float;
      nbAbsence : Natural;
   end record;

   --d�finition d'un ensemble de mati�res de type TabMatieres d�finie par
   --un tableau de mati�res
   type TabMatieres is array (1 .. MAX_MATIERES) of Matiere;

   --d�finition d'un ensemble d'�l�ves de type TabEleves d�finies par
   --un tableau d'�l�ves
   type TabEleves is array (1 .. MAX_ELEVES) of Eleve;

end sous_prog01;
