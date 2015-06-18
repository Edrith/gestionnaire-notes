package body tris is

   ---------------
   -- Trier_Nom --
   ---------------

   procedure Trier_Nom (T : in out TabEleves; n : in Natural) is
      j             : Natural;
      elementInsere : Eleve;
   begin
      for i in 1 .. n loop
         elementInsere := T (i);
         j             := i;
         while
           (j > 1
            and then To_String (T (j - 1).nom) > To_String (elementInsere.nom))
         loop
            T (j) := T (j - 1);
            j     := j - 1;
         end loop;
         T (j) := elementInsere;
      end loop;
   end Trier_Nom;

   -------------------
   -- Trier_Moyenne --
   -------------------

   procedure Trier_Moyenne (T : in out TabEleves; n : in Natural) is
      j             : Natural;
      elementInsere : Eleve;
   begin
      for i in 1 .. n loop
         elementInsere := T (i);
         j             := i;
         while (j > 1 and then T (j - 1).moyenne > elementInsere.moyenne) loop
            T (j) := T (j - 1);
            j     := j - 1;
         end loop;
         T (j) := elementInsere;
      end loop;
   end Trier_Moyenne;

   -----------------
   -- Trier_NbAbs --
   -----------------

   procedure Trier_NbAbs (T : in out TabEleves; n : in Natural) is
      j             : Natural;
      elementInsere : Eleve;
   begin
      for i in 1 .. n loop
         elementInsere := T (i);
         j             := i;
         while (j > 1 and then T (j - 1).nbAbsence > elementInsere.nbAbsence)
         loop
            T (j) := T (j - 1);
            j     := j - 1;
         end loop;
         T (j) := elementInsere;
      end loop;
   end Trier_NbAbs;

end tris;
