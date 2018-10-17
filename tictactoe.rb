#------------------------------------------------------------------------------------------------------------------------------------------------------------

class BoardCase#stocke le contenu d'une cellule de Board
    #chaque instance a 2 attr_accessor, sa valeur (X, O, ou vide) et son numéro de case
    attr_accessor :case_value, :case_nb
  
    def initialize(case_value, case_nb)
      #définit les valeur et numéro initiaux
      self.case_value = case_value
      self.case_nb = case_nb
    end
  
end
  
  #------------------------------------------------------------------------------------------------------------------------------------------------------------
  
class Board < BoardCase 
  
    #chaque instance est composée d'une table
    attr_accessor :board
  
    def initialize
      #A l'initialisation, céer 9 instances BoardCases
      #Ces instances sont rangées dans une array qui est l'attr_accessor de la classe
      @@board1 = []
  
      @case_0 = BoardCase.new(".", 0)
      @@board1 << @case_0
      @case_1 = BoardCase.new(".", 1)
      @@board1 << @case_1
      @case_2 = BoardCase.new(".", 2)
      @@board1 << @case_2
      @case_3 = BoardCase.new(".", 3)
      @@board1 << @case_3
      @case_4 = BoardCase.new(".", 4)
      @@board1 << @case_4
      @case_5 = BoardCase.new(".", 5)
      @@board1 << @case_5
      @case_6 = BoardCase.new(".", 6)
      @@board1 << @case_6
      @case_7 = BoardCase.new(".", 7)
      @@board1 << @case_7
      @case_8 = BoardCase.new(".", 8)
      @@board1 << @case_8
    end
  
    def display
    #Méthode pour afficher le plateau  
      puts " #{@case_0.case_value} | #{@case_1.case_value} | #{@case_2.case_value}"
      puts "-----------"
      puts " #{@case_3.case_value} | #{@case_4.case_value} | #{@case_5.case_value}"
      puts "-----------"
      puts " #{@case_6.case_value} | #{@case_7.case_value} | #{@case_8.case_value}"
    end
  
    def play
      #Méthode pour modifier le contenu de la BoardCase jouée par le joueur (par défaut X correspond au joueur 1 et O au joueur 2)
        if $count%2 == 1 then 
            @@board1.each do |v|
                if $temp_play == v.case_nb then v.case_value = "X" end
            end
        else
            @@board1.each do |v|
                if $temp_play == v.case_nb then v.case_value = "O" end 
            end
        end
        victory
    end
  
    def victory 
        #Methode qui teste s'il y a un vainqueur et relance un nouveau jeu dans ce cas ; sinon, elle lance un nouveau tour dans la class Game
        if [@@board1[0].case_value, @@board1[1].case_value, @@board1[2].case_value] == ["X"] * 3 || [@@board1[3].case_value, @@board1[4].case_value, @@board1[5].case_value] == ["X"] * 3 || [@@board1[6].case_value, @@board1[7].case_value, @@board1[8].case_value] == ["X"] * 3 || [@@board1[0].case_value, @@board1[3].case_value, @@board1[6].case_value] == ["X"] * 3 || [@@board1[1].case_value, @@board1[4].case_value, @@board1[7].case_value] == ["X"] * 3 || [@@board1[2].case_value, @@board1[5].case_value, @@board1[8].case_value] == ["X"] * 3 || [@@board1[0].case_value, @@board1[4].case_value, @@board1[8].case_value] == ["X"] * 3 || [@@board1[2].case_value, @@board1[4].case_value, @@board1[6].case_value] == ["X"] * 3
        then 
            $player1.state = "vainqueur" 
            puts "Bravo #{$player1.name}, tu as gagné !"
            puts " \n"
            $newboard.display
            puts "\n"
            #nextgame = Game.new.go

            while $player1.state = "vainqueur" 
              puts "Voulez-vous rejouer ? \n Tapez 1 pour oui, et nimportequelle touche pour non"
              input = gets.to_i
              if input == 1
                then nextgame = Game.new.go
              else exit 
              end
            end
        else
            if [@@board1[0].case_value, @@board1[1].case_value, @@board1[2].case_value] == ["O"] * 3 || [@@board1[3].case_value, @@board1[4].case_value, @@board1[5].case_value] == ["O"] * 3 || [@@board1[6].case_value, @@board1[7].case_value, @@board1[8].case_value] == ["O"] * 3 || [@@board1[0].case_value, @@board1[3].case_value, @@board1[6].case_value] == ["O"] * 3 || [@@board1[1].case_value, @@board1[4].case_value, @@board1[7].case_value] == ["O"] * 3 || [@@board1[2].case_value, @@board1[5].case_value, @@board1[8].case_value] == ["O"] * 3 || [@@board1[0].case_value, @@board1[4].case_value, @@board1[8].case_value] == ["O"] * 3 || [@@board1[2].case_value, @@board1[4].case_value, @@board1[6].case_value] == ["O"] * 3
            then $player2.state = "vainqueur"
                puts "Bravo #{$player2.name}, tu as gagné !"
                puts " \n"
                $newboard.display
                puts "\n"
                #nextgame = Game.new.go
                while $player2.state = "vainqueur"
              puts "Voulez-vous rejouer ? \n Tapez 1 pour oui, et nimportequelle touche pour non"
              puts "\n"
              input = gets.to_i
              if input == 1
                then nextgame = Game.new.go
              else exit 
              end
            end
            else
                display
                puts "\n"         
        
          end 
        end
    end

end
  
  #------------------------------------------------------------------------------------------------------------------------------------------------------------
  
class Player < Board
    #chaque instance a 2 attr_accessor, son nom et son état (vainqueur ou vide)
    attr_accessor :name, :state

    def initialize
      #initiliase le nom et son état (vide par défaut)
        puts "Quel est ton nom ?"
        self.name = gets.chomp
        self.state = ""
    end
end
  
  #------------------------------------------------------------------------------------------------------------------------------------------------------------
  
class Game < Player
    #chaque instance est un jeu
    attr_accessor :game


    def initialize
      #initialise en créant 2 joueurs et un board - les puts sont là comme des tests et vérifier ce qui fonctionne
       #méthode qui compte le nombre de tours, affiche le plateau, demande au joueur quel case il joue et renvoie vers la classe Board pour analyser sur un joueur à gagner
        puts "Bienvenue au jeu du Morpion !"
        puts " \n"
        puts "Le tableau de jeu est composé de 9 cases, que tu choisis par leur numéro, défini ci-dessous"
        puts " \n"
        puts " 1 | 2 | 3"
        puts "-----------"
        puts " 4 | 5 | 6"
        puts "-----------"
        puts " 7 | 8 | 9"  
        puts " \n"
        puts "Le joueur 1 est représenté par le symbole X et le joueur 2 par O"
        puts " \n"
        puts "Joueur 1 :"
        $player1 = Player.new
        puts "Joueur 2 :"
        $player2 = Player.new
        puts "\n"
        puts "Début de la partie !"  
        puts "\n"         
        $newboard = Board.new
        $newboard.display
        puts "\n"

      
        i=0
        while i <=9
        $count = i+=1
        
        puts "Changement de joueur ! \n Choisis une case libre entre 1 et 9"
        puts "\n"
        $temp_play = gets.chomp.to_i
        $temp_play = $temp_play -1
        $newboard.play

       
            while i>= 9
              puts " Partie nulle, tapez 1 pour en relancer une, et une touche au hasard pour quitter"
            input = gets.to_i
            if input == 1
              then nextgame = Game.new.go
            else exit
            end 
        end
      
    end

end
      
end

$game1 = Game.new