--programme principal gestionnaire.adb

with Ada.Text_IO;                   use Ada.Text_IO;
with Ada.Integer_Text_IO;           use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;             use Ada.Float_Text_IO;
with Ada.Strings.Unbounded;         use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
with sous_prog01;                   use sous_prog01;
with lecture_affichage; use lecture_affichage;
with tris;                          use tris;

procedure gestionnaire is
   matieres            : TabMatieres; --tableau de matieres
   eleves              : TabEleves; --tableau d'élèves
   chaine              : Unbounded_String; --chaine auxiliaire
   nom_lu_deja_inscrit : Boolean;
   cpt                 : Natural := 0; --compteur d'élèves inscrits
   somme               : Natural;
   numerateur          : Natural; --numérateur du calcul d'une moyenne
   denominateur        : Natural; --dénominateur du calcul d'une moyenne
   moins_bonne_note    : Natural; --la moins bonne note à une matière
   meilleure_note      : Natural; --la meilleure note à une matière
   nb_eleves_admis     : Natural; --nombre d'élèves ayant la moyenne

begin

   --DEBUT DU PROGRAMME
   Put_Line ("Bienvenue dans le Gestionnaire de Notes.");
   New_Line;

   --lire les coefficients des 6 notes et les noms des matières associés
   Put_Line ("Saisie des 6 différentes matières...");
   for i in TabMatieres'Range loop
      lire(matieres, i);
   end loop;
   New_Line;

   --lire les noms et notes de l'ensemble des élèves, en vérifiant qu'un même nom n'est pas entré plus d'une fois
   Put_Line ("Saisie des noms et notes des élèves...");
   --lire le nom d'un premier élève de l'ensemble des élèves inscrits ;
   Put_Line
     ("Veuillez entrer le nom d'un élève. Laissez vide et ""Entrée"" pour sortir.");
   chaine := To_Unbounded_String (Get_Line);
   --Tant Que le nom lu n'est pas vide Et qu'il n'est pas déja dans l'ensemble des élèves inscrits Faire
   --Tant que le nom lu n'est pas vide Faire
   while Length (chaine) /= 0 loop
      --le nom lu n'est pas deja inscrit ;
      nom_lu_deja_inscrit := False;
      --Pour chaque élève de l'ensemble des élèves inscrits Faire
      for i in eleves'Range loop
         --Si le nom de l'élève courant  = nom lu de l'élève Alors
         if chaine = eleves (i).nom then
            --le nom lu est déja inscrit ;
            Put (To_String (eleves (i).nom));
            Put_Line (" est déja inscrit...");
            nom_lu_deja_inscrit := True;
         end if;
      end loop;
      --Si le nom lu n'est pas déja inscrit Alors
      if not nom_lu_deja_inscrit then
         --il y a un élève de plus dans l'ensemble des élèves inscrits ;
         cpt              := cpt + 1;
         eleves (cpt).nom := chaine;
         --lire les notes de l'élève, en vérifiant : entiers naturels de 0 à 20 ou 99 , demander une nouvelle saisie si nécessaire
         --Pour chaque matière de l'ensemble des matières Faire
         for j in matieres'Range loop
            --afficher le nom de la matière ;
            --lire la note de l'élève pour cette matière, en vérifiant : entier naturel de 0 à 20 , ou 99 , demander une nouvelle saisie si nécessaire ;
            loop
               begin
                  Put ("Veuillez entrer la note de ");
                  Put (To_String (eleves (cpt).nom));
                  Put (" en ");
                  Put (To_String (matieres (j).nom));
                  Put_Line (" .");
                  Get (eleves (cpt).notes (j));
                  while eleves (cpt).notes (j) not in 0 .. 20 | 99 loop
                     Skip_Line;
                     Put_Line ("Une note doit être comprise de 0 à 20 ou 99");
                     Get (eleves (cpt).notes (j));
                  end loop;
                  exit;
               exception
                  when Data_Error =>
                     Skip_Line;
                     Put_Line
                       ("Bien essayé... Recommencez. Saisissez un entier naturel.");
               end;
            end loop;
         end loop;
      end if;
      Skip_Line;
      --lire le nom d'un élève ;
      Put_Line ("Veuillez entrer le nom d'un élève.");
      chaine := To_Unbounded_String (Get_Line);
   end loop;
   New_Line;
   --afficher les données saisies pour vérification
   Put_Line ("Affichage des données saisies pour vérification.");
   Put_Line ("Affichage des matières.");
   --Pour chaque matière Faire
   for i in matieres'Range loop
      Put (To_String (matieres (i).nom));
      Put (": coeff ");
      Put (matieres (i).coeff, Width => 3);
      Put_Line (" ");
   end loop;
   New_Line;
   Put_Line ("Affichage des élèves et de leurs notes.");
   --Pour chaque élève de l'ensemble des élèves inscrits Faire
   for i in 1 .. cpt loop
      --afficher son nom ;
      Put_Line (To_String (eleves (i).nom));
      --afficher ses notes
      --Pour chaque matière de l'ensemble des matières Faire
      for j in matieres'Range loop
         --afficher le nom de la matière ;
         Put (To_String (matieres (j).nom));
         Put (" : ");
         --afficher la note de l'élève pour cette matière ;
         Put (eleves (i).notes (j), Width => 3);
         Put_Line (" ");
      end loop;
   end loop;
   New_Line;
   --déterminer et afficher les noms des élèves n'ayant que des absences
   --Pour chaque élève de l'ensemble des élèves inscrits Faire
   for i in 1 .. cpt loop
      --calculer la somme des notes de l'élève
      --la somme des notes de l'élève est à 0 ;
      somme := 0;
      --Pour chaque note de l'ensemble des notes de l'élève Faire
      for j in TabNotes'Range loop
         --ajouter la valeur de la note à la somme des notes de l'élève ;
         somme := somme + eleves (i).notes (j);
      end loop;
      --Si la somme des notes de l'élève = 594 Alors
      if somme = 594 then
         --afficher le nom de l'élève comme étant totalement absent ;
         Put (To_String (eleves (i).nom));
         Put_Line (" n'a eu que des absences justifiées...");
      end if;
   end loop;
   New_Line;
   --calculer et afficher la moyenne de chaque élève ( en tenant compte des éventuelles absences ), ainsi que le nombre d'absences de chaque élève
   --Pour chaque élève de l'ensemble des élèves inscrits Faire
   Put_Line ("Moyenne de chaque élève.");
   for i in 1 .. cpt loop
   --calculer la moyenne de l'élève en tenant compte des éventuelles absences
      --le numérateur du calcul de la moyenne de l'élève est à 0 ;
      numerateur := 0;
      --le dénominateur du calcul de la moyenne de l'élève est à 0 ;
      denominateur :=
        0; --c'est pas très correct de laisser un dénominateur à zéro...
      eleves (i).nbAbsence := 0;
      --Pour chaque note de l'ensemble des notes de l'élève Faire
      for j in eleves (i).notes'Range loop
         --Si la note est differente de 99 Alors
         if eleves (i).notes (j) /= 99 then
            --ajouter le coefficient de la matière au dénominateur du calcul de la moyenne de l'élève ;
            denominateur := denominateur + matieres (j).coeff;
            --ajouter la note (valeur * coeff) au numérateur du calcul de la moyenne de l'élève ;
            numerateur :=
              numerateur + eleves (i).notes (j) * matieres (j).coeff;
         else
            --incrémenter le nombre d'absence de l'élève ;
            eleves (i).nbAbsence := eleves (i).nbAbsence + 1;
         end if;
      end loop;
      --diviser le numérateur par le dénominateur pour obtenir la moyenne de l'élève ;
      eleves (i).moyenne := Float (numerateur) / Float (denominateur);
      --afficher le nom de l'élève ;
      Put (To_String (eleves (i).nom));
      --afficher la moyenne de l'élève
      --Si la moyenne de l'élève est 99 Alors
      if eleves (i).moyenne = 99.0 then
         --afficher que l'élève a été totalement absent ;
         Put_Line (" a été totalement absent : Pas de moyenne.");
      else
         --afficher la valeur de la moyenne de l'élève ;
         Put (" a ");
         Put (eleves (i).moyenne, Exp => 0, Aft => 1);
         Put_Line (" de moyenne générale.");
      end if;
      --afficher le nombre d'absence de l'élève ;
      Put ("Nombre d'absence(s) justifiée(s) : ");
      Put (eleves (i).nbAbsence, Width => 3);
      Put_Line (" ");
   end loop;
   New_Line;
   --pour chaque matière, calculer, si possible, et afficher la moyenne, la moins bonne note et la meilleure note
   Put_Line ("Moyenne de chaque matière.");
   --Pour chaque matière Faire
   for i in matieres'Range loop
      --calculer la moyenne de la matière parmi l'ensemble des élèves inscrits
      --le numérateur du calcul de la moyenne de la matière est à 0 ;
      numerateur := 0;
      --le dénominateur du calcul de la moyenne de la matière est à 0 ;
      denominateur := 0;
      --Pour chaque élève de l'ensemble des élèves inscrits Faire
      for j in 1 .. cpt loop
         --Si la note de l'élève à cette matière est differente de 99 Alors
         if eleves (j).notes (i) /= 99 then
         --incrémenter le dénominateur du calcul de la moyenne de la matière ;
            denominateur := denominateur + 1;
            --ajouter la valeur de la note au numérateur du calcul de la moyenne de la matière ;
            numerateur := numerateur + eleves (j).notes (i);
         end if;
      end loop;
      --diviser le numérateur par le dénominateur pour obtenir la moyenne de la matière ;
      matieres (i).moyenne := Float (numerateur) / Float (denominateur);
      --déterminer la moins bonne note et la meilleure note de la matière parmi l'ensemble des élèves inscrits
      --lire la note de cette matière du premier élève inscrit dans l'ensemble des élèves inscrits ;
   --la moins bonne note de la matière est celle de ce premier élève inscrit ;
      moins_bonne_note := eleves (1).notes (i);
      --la meilleure note de la matière est celle de ce premier élève inscrit ;
      meilleure_note := eleves (1).notes (i);
      --Pour chaque autre élève de l'ensemble des élèves inscrits Faire
      for j in 2 .. cpt loop
         --lire la note de l'élève à cette matière ;
         --Si la note de l'élève à cette matière est inférieure à la moins bonne note de la matière Alors
         if eleves (j).notes (i) < moins_bonne_note then
            --la moins bonne note de la matière est celle de l'élève courant ;
            moins_bonne_note := eleves (j).notes (i);
         --Sinon Si la note de l'élève à cette matière est supérieure à la meilleure note la matière Alors
         elsif eleves (j).notes (i) > meilleure_note and
           eleves (j).notes (i) /= 99
         then
            --la meilleure note de la matière est celle de l'élève courant ;
            meilleure_note := eleves (j).notes (i);
         end if;
      end loop;
   --afficher la moyenne de la matière parmi l'ensemble des élèves inscrits ;
      Put ("En ");
      Put (To_String (matieres (i).nom));
      Put (", la moyenne est de : ");
      Put (matieres (i).moyenne, Exp => 0, Aft => 1);
      Put_Line (" ");
      --afficher la moins bonne note et la meilleure note de la matière parmi l'ensemble des élèves inscrits ;
      Put ("La moins bonne note est : ");
      Put (moins_bonne_note, Width => 3);
      Put_Line (" ");
      Put ("La meilleure note est : ");
      Put (meilleure_note, Width => 3);
      Put_Line (" ");
   end loop;
   New_Line;
   --déterminer et afficher les noms et les moyennes des élèves ayant une moyenne supérieure ou égale à 10 ainsi que leur nombre
   Put_Line ("Eleves ayant été admis cette année.");
   Put_Line ("Nom        Moyenne");
   --le nombre d'élève admis est à 0 ;
   nb_eleves_admis := 0;
   --Pour chaque élève de l'ensemble des élèves inscrits Faire
   for i in 1 .. cpt loop
      --Si la moyenne de l'élève est supérieure ou égale à 10 Alors
      if eleves (i).moyenne >= 10.0 then
         --afficher le nom de l'élève ;
         Put (To_String (eleves (i).nom));
         Put ("    ");
         --afficher la moyenne de l'élève ;
         Put (eleves (i).moyenne, Exp => 0, Aft => 1);
         --incrémenter le nombre d'élèves admis ;
         nb_eleves_admis := nb_eleves_admis + 1;
         Put_Line (" ");
      end if;
   end loop;
   --afficher le nombre d'élève admis ;
   Put ("Il y a ");
   Put (nb_eleves_admis, Width => 3);
   Put_Line (" admis cette année. Félicitations à eux !");
   New_Line;
   --afficher les noms, les moyennes et les nombres d'absences des élèves triés par ordre alphabétique du nom
   Put_Line
     ("Affichage des noms, moyennes et nombres d'absences des élèves triés par ordre alphabétique du nom.");
   Put_Line ("Nom        Moyenne  Absences");
   --trier l'ensemble des élèves inscrits par ordre alphabétique du nom
   Trier_Nom (eleves, cpt);
   --Pour chaque élève de l'ensemble des élèves inscrits Faire
   for i in 1 .. cpt loop
      --afficher le nom de l'élève ;
      Put (To_String (eleves (i).nom));
      Put("    ");
      --afficher la moyenne de l'élève ;
      Put (eleves (i).moyenne, Exp => 0, Aft => 1);
      Put("    ");
      --afficher le nombre d'absence justifiée de l'élève ;
      Put (eleves (i).nbAbsence, Width => 3);
      Put_Line (" ");
   end loop;
   New_Line;
   --afficher les noms, les moyennes et les nombres d'absences des élèves triés par moyenne décroissante
   Put_Line
     ("Affichage des noms, moyennes et nombres d'absences des élèves triés par moyenne décroissante.");
   Put_Line ("Nom        Moyenne  Absences");
--trier l'ensemble des élèves inscrits par moyenne croissante
   Trier_Moyenne (eleves, cpt);
--afficher par ordre décroissant l'ensemble d'élève triées
--Pour chaque élève de l'ensemble des élèves inscrits Faire
   for i in reverse 1 .. cpt loop
      --afficher le nom de l'élève ;
      Put (To_String (eleves (i).nom));
      Put("    ");
      --afficher la moyenne de l'élève ;
      Put (eleves (i).moyenne, Exp => 0, Aft => 1);
      Put("    ");
      --afficher le nombre d'absence justifiée de l'élève ;
      Put (eleves (i).nbAbsence, Width => 3);
      Put_Line (" ");
   end loop;
   New_Line;
   --afficher les noms, les moyennes et les nombres d'absences des élèves triés par nombre d'absences décroissant
   Put_Line
     ("Affichage des noms, moyennes et nombres d'absences des élèves triés par nombre d'absences justifiées décroissante.");
   Put_Line ("Nom            Moyenne  Absences");
   --trier l'ensemble des élèves inscrits par nombre d'absence croissante ;
   Trier_NbAbs (eleves, cpt);
   --Pour chaque élève de l'ensemble des élèves inscrits Faire
   for i in reverse 1 .. cpt loop
      --afficher le nom de l'élève ;
      Put (To_String (eleves (i).nom));
      --afficher la moyenne de l'élève ;
      Put (eleves (i).moyenne, Exp => 0, Aft => 1);
      --afficher le nombre d'absence justifiée de l'élève ;
      Put (eleves (i).nbAbsence, Width => 3);
      Put_Line (" ");
   end loop;
   New_Line;
   Put_Line ("Fin du Programme.");

end gestionnaire;
