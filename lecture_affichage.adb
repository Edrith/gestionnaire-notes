with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;         use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;

package body lecture_affichage is

   ----------
   -- lire --
   ----------

   procedure lire (matieres : in out TabMatieres; i : in Natural) is
   begin
      --lire le nom d'une mati�re ;
      Put_Line ("Veuillez entrer le nom d'une mati�re.");
      matieres (i).nom := To_Unbounded_String (Get_Line);
      while Length (matieres (i).nom) = 0 loop
         Put_Line
           ("Pourquoi un nom de mati�res vide ? Veuillez recommencez, svp.");
         matieres (i).nom := To_Unbounded_String (Get_Line);
      end loop;
      --lire le coefficient de cette mati�re en v�rifiant :
      --entier naturel non nul , demander une nouvelle saisie si n�cessaire ;
      loop
         begin
            Put ("Veuillez entrer le coefficient en ");
            Put (To_String (matieres (i).nom));
            Put_Line (" .");
            Get (matieres (i).coeff);
            while matieres (i).coeff = 0 loop
               Skip_Line;
               Put_Line
                 ("Un coefficient ne peut pas �tre �gal � 0. Recomencez.");
               Get (matieres (i).coeff);
            end loop;
            exit;
         exception
            when Data_Error | Constraint_Error =>
               Skip_Line;
               Put_Line
                 ("Bien essay�... Recommencez. Saisissez un entier naturel.");
         end;
      end loop;
      Skip_Line;
   end lire;

end lecture_affichage;
