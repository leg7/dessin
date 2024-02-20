%skeleton "lalr1.cc"
%require "3.0"

%defines
%define api.parser.class { Parser }
%define api.value.type variant
%define parse.assert

%locations

%code requires {
	#include "Driver.h"
	#include "../instructions/Instructions.h"
	#include "../elements/formes/Formes.h"
	#include <iostream>

	class Scanner;
	class Driver;
}

%parse-param { Scanner &scanner }
%parse-param { Driver &driver }

%code{
	#undef	yylex
	#define yylex scanner.yylex

}

%token NL
%token END
%token <int> NUMBER
%token FLECHE

%token COULEUR
%token COULEUR_RGB
%token <unsigned> COULEUR_HEX
%token <Couleur> COULEUR_NOM

%token ROTATION
%token REMPLISSAGE
%token OPACITE
%token EPAISSEUR

%token CARRE
%token RECTANGLE
%token TRIANGLE
%token CERCLE
%token ELLIPSE
%token LIGNE
%token CHEMIN
%token TEXTE
%token <const char*> STRING

%type <int> operation
%type <std::shared_ptr<Forme>> proprietes
%type <std::shared_ptr<Forme>> propriete
%type <Couleur> couleur
%type <std::shared_ptr<Declaration>> declaration
%type <std::shared_ptr<Declaration>> declarationSimple
%type <std::shared_ptr<Chemin> chemin_points
%left '-' '+'
%left '*' '/'
%precedence  NEG

%%

programme:
	instruction NL programme
	| END NL {
		YYACCEPT;
	}

instruction:
	 affectation {
		driver.ast.add($$);
	}
	| appelFonction {
		driver.ast.add($$);
	}
	| boucle {
		driver.ast.add($$);
	}
	| branchement {
		driver.ast.add($$);
	}
	| declaration {
		driver.ast.add($$);
	}


// TODO: Construire forme puis l'ajouter au contexte de l'AST
declaration:
	forme
	| forme proprietes {
		$2 = $1;
	}

forme:
	CARRE NUMBER NUMBER NUMBER {
		$$ = std::make_shared<Declaration>(driver.contexteCourant, std::make_shared<Carre>($2, $3, $4));
	}
	| RECTANGLE NUMBER NUMBER NUMBER NUMBER NUMBER NUMBER NUMBER NUMBER {
		$$ = std::make_shared<Declaration>(driver.contexteCourant, std::make_shared<Rectangle>($2, $3, $4, $5, $6, $7, $8, $9));
	}
	| TRIANGLE NUMBER NUMBER NUMBER NUMBER {
		$$ = std::make_shared<Declaration>(driver.contexteCourant, std::make_shared<Triangle>($2, $3, $4, $5));
	}
	| CERCLE NUMBER NUMBER NUMBER {
		$$ = std::make_shared<Declaration>(driver.contexteCourant, std::make_shared<Cercle>($2, $3, $4));
	}
	| ELLIPSE NUMBER NUMBER NUMBER NUMBER {
		$$ = std::make_shared<Declaration>(driver.contexteCourant, std::make_shared<Ellipse>($2, $3, $4, $5));
	}
	| LIGNE NUMBER NUMBER NUMBER NUMBER {
		$$ = std::make_shared<Declaration>(driver.contexteCourant, std::make_shared<Ligne>($2, $3, $4, $5));
	}
	| CHEMIN chemin_points {
		$$ = std::make_shared<Declaration>(driver.contexteCourant, $2);
	}
	| TEXTE NUMBER NUMBER STRING STRING {
		$$ = std::make_shared<Declaration>(driver.contexteCourant, std::make_shared<Texte>($2, $3, $4, $5));
	}

chemin_points:
	chemin_points ',' NUMBER NUMBER  {
		$1->ajoutePoint($3, $4);
		$$ = std::move($1);
	}
	| NUMBER NUMBER {
		$$ = std::make_shared<Chemin>($1, $2);
	}

proprietes:
	FLECHE propriete_esp ';' {
		$2 = $$; // idem
	}
	| '{' propriete_nl '}' {
		$$ = $2; // TODO: Il faudra changer cette ligne pour que le prop inclu propriete_nl
	}

propriete:
	COULEUR ':' couleur {
		$$->setCouleur($3);
	}
	| ROTATION ':' NUMBER {
		$$->setRotation($3 % 360);
	}
	| REMPLISSAGE ':' couleur {
		$$->setRemplissage($3);
	}
	| OPACITE ':' NUMBER '%' {
		$$->setOpacite($3);
	}
	| EPAISSEUR ':' NUMBER {
		$$->setEpaisseur($3);
	}

couleur:
	COULEUR_NOM {
		$$ = Couleur($1);
	}
	| COULEUR_RGB NUMBER ',' NUMBER ',' NUMBER ')' {
		$$ = Couleur($2, $4, $6);
	}
	| COULEUR_HEX {
		Hextract h { $1 };
		$$ = Couleur(h.parts.r, h.parts.g, h.parts.b);
	}

propriete_esp:
	propriete '&' propriete_esp
	| propriete

propriete_nl:
	propriete_nl NL propriete
 	| propriete

affectation:
    /*IDENTIFIANT '=' expression {

        std::cout << "Affectation à réaliser" << std::endl;
    }*/

appelFonction:

boucle:

branchement:


operation:
	NUMBER {
		$$ = $1;
	}
	| '(' operation ')' {
		$$ = $2;
	}
	| operation '+' operation {
		$$ = $1 + $3;
	}
	| operation '-' operation {
		$$ = $1 - $3;
	}
	| operation '*' operation {
		$$ = $1 * $3;
	}
	| operation '/' operation {
		$$ = $1 / $3;
	}
	| '-' operation %prec NEG {
		$$ = - $2;
	}

%%

void yy::Parser::error( const location_type &l, const std::string & err_msg) {
	std::cerr << "Erreur : " << l << ", " << err_msg << std::endl;
}
