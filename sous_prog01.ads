--spécification de paquetage sous_prog01.ads

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package sous_prog01 is

   MAX_MATIERES : constant Natural := 6; --nombre maximum de matières étudiées
   MAX_ELEVES   : constant Natural := 100; --nombre maximum d'élèves

   --définition d'un ensemble de notes de type TabNotes définie par
   --un tableau d'entiers naturels
   type TabNotes is array (1 .. MAX_MATIERES) of Natural;

   --définition d'un type Matiere caractérisé par un nom 'nom',
   --d'un coefficient 'coeff' appliqué aux notes de cette matière
   --et d'une moyenne générale de la classe à cette matière
   type Matiere is record
      nom   : Unbounded_String;
      coeff : Natural;
      moyenne : Float;
   end record;

   --définition d'un type Eleve caractiérisé par un nom 'nom', un ensemble de
   --notes 'notes', une moyenne générale 'moyenne' et un nombre d'absences
   --justifiées 'nbAbsence'
   type Eleve is record
      nom     : Unbounded_String;
      notes   : TabNotes;
      moyenne : Float;
      nbAbsence : Natural;
   end record;

   --définition d'un ensemble de matières de type TabMatieres définie par
   --un tableau de matières
   type TabMatieres is array (1 .. MAX_MATIERES) of Matiere;

   --définition d'un ensemble d'élèves de type TabEleves définies par
   --un tableau d'élèves
   type TabEleves is array (1 .. MAX_ELEVES) of Eleve;

end sous_prog01;
