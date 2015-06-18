--spécification de paquetage tris.ads
with sous_prog01;           use sous_prog01;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package tris is

   --tri par ordre alphabétique du nom un ensemble d'élèves 'T'
   --constitué de 'n' élèves
   procedure Trier_Nom (T : in out TabEleves; n : in Natural) with
      Post =>
      (for all i in 1 .. n - 1 =>
         To_String (T (i).nom) <= To_String (T (i + 1).nom));

      --tri par ordre croissant de leur moyenne un ensemble d'élèves 'T'
      --constitué de 'n' élèves
   procedure Trier_Moyenne (T : in out TabEleves; n : in Natural) with
      Post => (for all i in 1 .. n - 1 => T (i).moyenne <= T (i + 1).moyenne);

      --tri par ordre croissant de leur nombres d'absences un ensemble
      --d'élèves 'T' constitué de 'n' élèves
   procedure Trier_NbAbs (T : in out TabEleves; n : in Natural) with
      Post =>
      (for all i in 1 .. n - 1 => T (i).nbAbsence <= T (i + 1).nbAbsence);
end tris;
