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
   eleves              : TabEleves; --tableau d'�l�ves
   chaine              : Unbounded_String; --chaine auxiliaire
   nom_lu_deja_inscrit : Boolean;
   cpt                 : Natural := 0; --compteur d'�l�ves inscrits
   somme               : Natural;
   numerateur          : Natural; --num�rateur du calcul d'une moyenne
   denominateur        : Natural; --d�nominateur du calcul d'une moyenne
   moins_bonne_note    : Natural; --la moins bonne note � une mati�re
   meilleure_note      : Natural; --la meilleure note � une mati�re
   nb_eleves_admis     : Natural; --nombre d'�l�ves ayant la moyenne

begin

   --DEBUT DU PROGRAMME
   Put_Line ("Bienvenue dans le Gestionnaire de Notes.");
   New_Line;

   --lire les coefficients des 6 notes et les noms des mati�res associ�s
   Put_Line ("Saisie des 6 diff�rentes mati�res...");
   for i in TabMatieres'Range loop
      lire(matieres, i);
   end loop;
   New_Line;

   --lire les noms et notes de l'ensemble des �l�ves, en v�rifiant qu'un m�me nom n'est pas entr� plus d'une fois
   Put_Line ("Saisie des noms et notes des �l�ves...");
   --lire le nom d'un premier �l�ve de l'ensemble des �l�ves inscrits ;
   Put_Line
     ("Veuillez entrer le nom d'un �l�ve. Laissez vide et ""Entr�e"" pour sortir.");
   chaine := To_Unbounded_String (Get_Line);
   --Tant Que le nom lu n'est pas vide Et qu'il n'est pas d�ja dans l'ensemble des �l�ves inscrits Faire
   --Tant que le nom lu n'est pas vide Faire
   while Length (chaine) /= 0 loop
      --le nom lu n'est pas deja inscrit ;
      nom_lu_deja_inscrit := False;
      --Pour chaque �l�ve de l'ensemble des �l�ves inscrits Faire
      for i in eleves'Range loop
         --Si le nom de l'�l�ve courant  = nom lu de l'�l�ve Alors
         if chaine = eleves (i).nom then
            --le nom lu est d�ja inscrit ;
            Put (To_String (eleves (i).nom));
            Put_Line (" est d�ja inscrit...");
            nom_lu_deja_inscrit := True;
         end if;
      end loop;
      --Si le nom lu n'est pas d�ja inscrit Alors
      if not nom_lu_deja_inscrit then
         --il y a un �l�ve de plus dans l'ensemble des �l�ves inscrits ;
         cpt              := cpt + 1;
         eleves (cpt).nom := chaine;
         --lire les notes de l'�l�ve, en v�rifiant : entiers naturels de 0 � 20 ou 99 , demander une nouvelle saisie si n�cessaire
         --Pour chaque mati�re de l'ensemble des mati�res Faire
         for j in matieres'Range loop
            --afficher le nom de la mati�re ;
            --lire la note de l'�l�ve pour cette mati�re, en v�rifiant : entier naturel de 0 � 20 , ou 99 , demander une nouvelle saisie si n�cessaire ;
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
                     Put_Line ("Une note doit �tre comprise de 0 � 20 ou 99");
                     Get (eleves (cpt).notes (j));
                  end loop;
                  exit;
               exception
                  when Data_Error =>
                     Skip_Line;
                     Put_Line
                       ("Bien essay�... Recommencez. Saisissez un entier naturel.");
               end;
            end loop;
         end loop;
      end if;
      Skip_Line;
      --lire le nom d'un �l�ve ;
      Put_Line ("Veuillez entrer le nom d'un �l�ve.");
      chaine := To_Unbounded_String (Get_Line);
   end loop;
   New_Line;
   --afficher les donn�es saisies pour v�rification
   Put_Line ("Affichage des donn�es saisies pour v�rification.");
   Put_Line ("Affichage des mati�res.");
   --Pour chaque mati�re Faire
   for i in matieres'Range loop
      Put (To_String (matieres (i).nom));
      Put (": coeff ");
      Put (matieres (i).coeff, Width => 3);
      Put_Line (" ");
   end loop;
   New_Line;
   Put_Line ("Affichage des �l�ves et de leurs notes.");
   --Pour chaque �l�ve de l'ensemble des �l�ves inscrits Faire
   for i in 1 .. cpt loop
      --afficher son nom ;
      Put_Line (To_String (eleves (i).nom));
      --afficher ses notes
      --Pour chaque mati�re de l'ensemble des mati�res Faire
      for j in matieres'Range loop
         --afficher le nom de la mati�re ;
         Put (To_String (matieres (j).nom));
         Put (" : ");
         --afficher la note de l'�l�ve pour cette mati�re ;
         Put (eleves (i).notes (j), Width => 3);
         Put_Line (" ");
      end loop;
   end loop;
   New_Line;
   --d�terminer et afficher les noms des �l�ves n'ayant que des absences
   --Pour chaque �l�ve de l'ensemble des �l�ves inscrits Faire
   for i in 1 .. cpt loop
      --calculer la somme des notes de l'�l�ve
      --la somme des notes de l'�l�ve est � 0 ;
      somme := 0;
      --Pour chaque note de l'ensemble des notes de l'�l�ve Faire
      for j in TabNotes'Range loop
         --ajouter la valeur de la note � la somme des notes de l'�l�ve ;
         somme := somme + eleves (i).notes (j);
      end loop;
      --Si la somme des notes de l'�l�ve = 594 Alors
      if somme = 594 then
         --afficher le nom de l'�l�ve comme �tant totalement absent ;
         Put (To_String (eleves (i).nom));
         Put_Line (" n'a eu que des absences justifi�es...");
      end if;
   end loop;
   New_Line;
   --calculer et afficher la moyenne de chaque �l�ve ( en tenant compte des �ventuelles absences ), ainsi que le nombre d'absences de chaque �l�ve
   --Pour chaque �l�ve de l'ensemble des �l�ves inscrits Faire
   Put_Line ("Moyenne de chaque �l�ve.");
   for i in 1 .. cpt loop
   --calculer la moyenne de l'�l�ve en tenant compte des �ventuelles absences
      --le num�rateur du calcul de la moyenne de l'�l�ve est � 0 ;
      numerateur := 0;
      --le d�nominateur du calcul de la moyenne de l'�l�ve est � 0 ;
      denominateur :=
        0; --c'est pas tr�s correct de laisser un d�nominateur � z�ro...
      eleves (i).nbAbsence := 0;
      --Pour chaque note de l'ensemble des notes de l'�l�ve Faire
      for j in eleves (i).notes'Range loop
         --Si la note est differente de 99 Alors
         if eleves (i).notes (j) /= 99 then
            --ajouter le coefficient de la mati�re au d�nominateur du calcul de la moyenne de l'�l�ve ;
            denominateur := denominateur + matieres (j).coeff;
            --ajouter la note (valeur * coeff) au num�rateur du calcul de la moyenne de l'�l�ve ;
            numerateur :=
              numerateur + eleves (i).notes (j) * matieres (j).coeff;
         else
            --incr�menter le nombre d'absence de l'�l�ve ;
            eleves (i).nbAbsence := eleves (i).nbAbsence + 1;
         end if;
      end loop;
      --diviser le num�rateur par le d�nominateur pour obtenir la moyenne de l'�l�ve ;
      eleves (i).moyenne := Float (numerateur) / Float (denominateur);
      --afficher le nom de l'�l�ve ;
      Put (To_String (eleves (i).nom));
      --afficher la moyenne de l'�l�ve
      --Si la moyenne de l'�l�ve est 99 Alors
      if eleves (i).moyenne = 99.0 then
         --afficher que l'�l�ve a �t� totalement absent ;
         Put_Line (" a �t� totalement absent : Pas de moyenne.");
      else
         --afficher la valeur de la moyenne de l'�l�ve ;
         Put (" a ");
         Put (eleves (i).moyenne, Exp => 0, Aft => 1);
         Put_Line (" de moyenne g�n�rale.");
      end if;
      --afficher le nombre d'absence de l'�l�ve ;
      Put ("Nombre d'absence(s) justifi�e(s) : ");
      Put (eleves (i).nbAbsence, Width => 3);
      Put_Line (" ");
   end loop;
   New_Line;
   --pour chaque mati�re, calculer, si possible, et afficher la moyenne, la moins bonne note et la meilleure note
   Put_Line ("Moyenne de chaque mati�re.");
   --Pour chaque mati�re Faire
   for i in matieres'Range loop
      --calculer la moyenne de la mati�re parmi l'ensemble des �l�ves inscrits
      --le num�rateur du calcul de la moyenne de la mati�re est � 0 ;
      numerateur := 0;
      --le d�nominateur du calcul de la moyenne de la mati�re est � 0 ;
      denominateur := 0;
      --Pour chaque �l�ve de l'ensemble des �l�ves inscrits Faire
      for j in 1 .. cpt loop
         --Si la note de l'�l�ve � cette mati�re est differente de 99 Alors
         if eleves (j).notes (i) /= 99 then
         --incr�menter le d�nominateur du calcul de la moyenne de la mati�re ;
            denominateur := denominateur + 1;
            --ajouter la valeur de la note au num�rateur du calcul de la moyenne de la mati�re ;
            numerateur := numerateur + eleves (j).notes (i);
         end if;
      end loop;
      --diviser le num�rateur par le d�nominateur pour obtenir la moyenne de la mati�re ;
      matieres (i).moyenne := Float (numerateur) / Float (denominateur);
      --d�terminer la moins bonne note et la meilleure note de la mati�re parmi l'ensemble des �l�ves inscrits
      --lire la note de cette mati�re du premier �l�ve inscrit dans l'ensemble des �l�ves inscrits ;
   --la moins bonne note de la mati�re est celle de ce premier �l�ve inscrit ;
      moins_bonne_note := eleves (1).notes (i);
      --la meilleure note de la mati�re est celle de ce premier �l�ve inscrit ;
      meilleure_note := eleves (1).notes (i);
      --Pour chaque autre �l�ve de l'ensemble des �l�ves inscrits Faire
      for j in 2 .. cpt loop
         --lire la note de l'�l�ve � cette mati�re ;
         --Si la note de l'�l�ve � cette mati�re est inf�rieure � la moins bonne note de la mati�re Alors
         if eleves (j).notes (i) < moins_bonne_note then
            --la moins bonne note de la mati�re est celle de l'�l�ve courant ;
            moins_bonne_note := eleves (j).notes (i);
         --Sinon Si la note de l'�l�ve � cette mati�re est sup�rieure � la meilleure note la mati�re Alors
         elsif eleves (j).notes (i) > meilleure_note and
           eleves (j).notes (i) /= 99
         then
            --la meilleure note de la mati�re est celle de l'�l�ve courant ;
            meilleure_note := eleves (j).notes (i);
         end if;
      end loop;
   --afficher la moyenne de la mati�re parmi l'ensemble des �l�ves inscrits ;
      Put ("En ");
      Put (To_String (matieres (i).nom));
      Put (", la moyenne est de : ");
      Put (matieres (i).moyenne, Exp => 0, Aft => 1);
      Put_Line (" ");
      --afficher la moins bonne note et la meilleure note de la mati�re parmi l'ensemble des �l�ves inscrits ;
      Put ("La moins bonne note est : ");
      Put (moins_bonne_note, Width => 3);
      Put_Line (" ");
      Put ("La meilleure note est : ");
      Put (meilleure_note, Width => 3);
      Put_Line (" ");
   end loop;
   New_Line;
   --d�terminer et afficher les noms et les moyennes des �l�ves ayant une moyenne sup�rieure ou �gale � 10 ainsi que leur nombre
   Put_Line ("Eleves ayant �t� admis cette ann�e.");
   Put_Line ("Nom        Moyenne");
   --le nombre d'�l�ve admis est � 0 ;
   nb_eleves_admis := 0;
   --Pour chaque �l�ve de l'ensemble des �l�ves inscrits Faire
   for i in 1 .. cpt loop
      --Si la moyenne de l'�l�ve est sup�rieure ou �gale � 10 Alors
      if eleves (i).moyenne >= 10.0 then
         --afficher le nom de l'�l�ve ;
         Put (To_String (eleves (i).nom));
         Put ("    ");
         --afficher la moyenne de l'�l�ve ;
         Put (eleves (i).moyenne, Exp => 0, Aft => 1);
         --incr�menter le nombre d'�l�ves admis ;
         nb_eleves_admis := nb_eleves_admis + 1;
         Put_Line (" ");
      end if;
   end loop;
   --afficher le nombre d'�l�ve admis ;
   Put ("Il y a ");
   Put (nb_eleves_admis, Width => 3);
   Put_Line (" admis cette ann�e. F�licitations � eux !");
   New_Line;
   --afficher les noms, les moyennes et les nombres d'absences des �l�ves tri�s par ordre alphab�tique du nom
   Put_Line
     ("Affichage des noms, moyennes et nombres d'absences des �l�ves tri�s par ordre alphab�tique du nom.");
   Put_Line ("Nom        Moyenne  Absences");
   --trier l'ensemble des �l�ves inscrits par ordre alphab�tique du nom
   Trier_Nom (eleves, cpt);
   --Pour chaque �l�ve de l'ensemble des �l�ves inscrits Faire
   for i in 1 .. cpt loop
      --afficher le nom de l'�l�ve ;
      Put (To_String (eleves (i).nom));
      Put("    ");
      --afficher la moyenne de l'�l�ve ;
      Put (eleves (i).moyenne, Exp => 0, Aft => 1);
      Put("    ");
      --afficher le nombre d'absence justifi�e de l'�l�ve ;
      Put (eleves (i).nbAbsence, Width => 3);
      Put_Line (" ");
   end loop;
   New_Line;
   --afficher les noms, les moyennes et les nombres d'absences des �l�ves tri�s par moyenne d�croissante
   Put_Line
     ("Affichage des noms, moyennes et nombres d'absences des �l�ves tri�s par moyenne d�croissante.");
   Put_Line ("Nom        Moyenne  Absences");
--trier l'ensemble des �l�ves inscrits par moyenne croissante
   Trier_Moyenne (eleves, cpt);
--afficher par ordre d�croissant l'ensemble d'�l�ve tri�es
--Pour chaque �l�ve de l'ensemble des �l�ves inscrits Faire
   for i in reverse 1 .. cpt loop
      --afficher le nom de l'�l�ve ;
      Put (To_String (eleves (i).nom));
      Put("    ");
      --afficher la moyenne de l'�l�ve ;
      Put (eleves (i).moyenne, Exp => 0, Aft => 1);
      Put("    ");
      --afficher le nombre d'absence justifi�e de l'�l�ve ;
      Put (eleves (i).nbAbsence, Width => 3);
      Put_Line (" ");
   end loop;
   New_Line;
   --afficher les noms, les moyennes et les nombres d'absences des �l�ves tri�s par nombre d'absences d�croissant
   Put_Line
     ("Affichage des noms, moyennes et nombres d'absences des �l�ves tri�s par nombre d'absences justifi�es d�croissante.");
   Put_Line ("Nom            Moyenne  Absences");
   --trier l'ensemble des �l�ves inscrits par nombre d'absence croissante ;
   Trier_NbAbs (eleves, cpt);
   --Pour chaque �l�ve de l'ensemble des �l�ves inscrits Faire
   for i in reverse 1 .. cpt loop
      --afficher le nom de l'�l�ve ;
      Put (To_String (eleves (i).nom));
      --afficher la moyenne de l'�l�ve ;
      Put (eleves (i).moyenne, Exp => 0, Aft => 1);
      --afficher le nombre d'absence justifi�e de l'�l�ve ;
      Put (eleves (i).nbAbsence, Width => 3);
      Put_Line (" ");
   end loop;
   New_Line;
   Put_Line ("Fin du Programme.");

end gestionnaire;
