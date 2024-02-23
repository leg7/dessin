%skeleton "lalr1.cc"
%require "3.2"

%defines
%define api.parser.class { Parser }
%define api.value.type variant
%define parse.assert
%language "c++"

%locations

%code requires {
	#include <memory>
	#include <iostream>
	#include <cmath>
	#include <cstdint>

	#include "../expressions/ExpressionBinaire.h"
	#include "../expressions/ExpressionUnaire.h"
	#include "../expressions/Variable.h"
	#include "../expressions/Constante.h"

	#include "../instructions/Instruction.h"
	#include "../instructions/Affectation.h"
	#include "../instructions/AppelFonction.h"
	#include "../instructions/Boucle.h"
	#include "../instructions/Branchement.h"
	#include "../instructions/Declaration.h"

	#include "../elements/Taille.h"
	#include "../elements/Couleur.h"
	#include "../elements/ElementPrimitif.h"
	#include "../elements/formes/Forme.h"
	#include "../elements/formes/Carre.h"
	#include "../elements/formes/Cercle.h"
	#include "../elements/formes/Chemin.h"
	#include "../elements/formes/Ellipse.h"
	#include "../elements/formes/Ligne.h"
	#include "../elements/formes/Rectangle.h"
	#include "../elements/formes/Texte.h"
	#include "../elements/formes/Triangle.h"

	class Scanner;
	class Driver;
}

%parse-param { Scanner &scanner }
%parse-param { Driver &driver }

%code{
	#include "Driver.h"
	#include "scanner.hh"

	#undef	yylex
	#define yylex scanner.yylex

	bool estEntier(double x) { return ceil(x) == x; }
}

%token NL
%token END
%token <double> NOMBRE

%token FLECHE
%token <Couleur::Nom> COULEUR_NOM
%token COULEUR_RGB_START
%token <uint32_t> COULEUR_HEX

%token <std::string> IDENTIFIANT

%token KW_TAILLE
%token KW_COULEUR
%token KW_ROTATION
%token DEGREE
%token KW_REMPLISSAGE
%token KW_OPACITE
%token KW_EPAISSEUR
%token KW_TANTQUE
%token KW_SI
%token KW_BOOLEAN
%token KW_ENTIER
%token KW_REEL

%token <ExpressionBinaire::Operation> OP_ADD
%token <ExpressionBinaire::Operation> OP_MUL
%token <ExpressionBinaire::Operation> OP_DIV
%token <ExpressionBinaire::Operation> OP_EQ
%token <ExpressionBinaire::Operation> OP_GT
%token <ExpressionBinaire::Operation> OP_GE
%token <ExpressionBinaire::Operation> OP_LT
%token <ExpressionBinaire::Operation> OP_LE
%token <ExpressionBinaire::Operation> OP_AND
%token <ExpressionBinaire::Operation> OP_OR
%token <ExpressionUnaire::Operation> OP_NEG

%left OP_EQ OP_GT OP_GE OP_LT OP_LE OP_AND OP_OR
%left '-' OP_ADD OP_MUL OP_DIV
%precedence NEG

%token CARRE
%token RECTANGLE
%token TRIANGLE
%token CERCLE
%token ELLIPSE
%token LIGNE
%token CHEMIN
%token TEXTE
%token <std::string> STRING

%type <std::unique_ptr<Expression>> expression

%type <std::unique_ptr<Declaration>> declaration
%type <std::shared_ptr<Forme>> forme
%type <Forme::Proprietes> proplist_esp
%type <Forme::Proprietes> proplist_nl
%type <std::unique_ptr<Couleur>> couleur

%type <std::unique_ptr<Affectation>> affectation

%type <std::unique_ptr<AppelFonction>> appelFonction
%type <std::vector<std::shared_ptr<Instruction>>> arglist

%type <std::unique_ptr<Boucle>> boucle
%type <std::unique_ptr<Expression>> comparaison
%type <std::unique_ptr<Instruction>> instruction
%type <std::unique_ptr<Branchement>> branchement
%type <std::vector<std::shared_ptr<Instruction>>> corps
%type <int> operation
%type <std::unique_ptr<Chemin>> chemin_points


%%

programme:
	instruction NL programme
	| END NL {
		YYACCEPT;
	}

instruction:
/*
	| appelFonction {
		driver.ast.add($$);
	}
	| boucle {
		driver.ast.add($$);
	}
	| branchement {
		driver.ast.add($$);
	}
*/
	affectation {
		driver.ast.add(std::move($$));
	}
	| declaration {
		driver.ast.add(std::move($$));
	}
	| /* epsilon */

declaration:
	forme ';' {
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::move($1));
	}
	| forme FLECHE proplist_esp ';' {
		$1->setProprietes($3);
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::move($1));
	}
	| forme '{' NL proplist_nl '}' {
		$1->setProprietes($4);
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::move($1));
	}
	| IDENTIFIANT OP_EQ forme ';' {
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::move($3), $1);
	}
	| IDENTIFIANT OP_EQ forme FLECHE proplist_esp ';' {
		$3->setProprietes($5);
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::move($3), $1);
	}
	| IDENTIFIANT OP_EQ forme '{' NL proplist_nl '}' {
		$3->setProprietes($6);
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::move($3), $1);
	}
	| KW_COULEUR IDENTIFIANT OP_EQ couleur ';' {
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::move($4), $2);
	}
	| KW_BOOLEAN IDENTIFIANT OP_EQ expression ';' {
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::make_shared<ElementPrimitif<bool>>($4->eval()->toDouble()), $2);
	}
	| KW_ENTIER IDENTIFIANT OP_EQ NOMBRE ';' {
		if (!estEntier($4)) {
			std::cout << $4 << "n'est pas entier!\n";
			exit(69);
		}
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::make_shared<ElementPrimitif<int>>($4), $2);
	}
	| KW_REEL IDENTIFIANT OP_EQ NOMBRE ';' {
		if (estEntier($4)) {
			std::cout << $4 << "n'est pas flotant!\n";
			exit(69);
		}
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::make_shared<ElementPrimitif<double>>($4), $2);
	}
	| KW_TAILLE NOMBRE NOMBRE ';' {
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::make_shared<Taille>($2, $3), "taille");
	}

expression:
	expression OP_ADD expression {
		 $$ = std::make_unique<ExpressionBinaire>(std::move($1), std::move($3), $2);
	}
	| expression OP_MUL expression {
		 $$ = std::make_unique<ExpressionBinaire>(std::move($1), std::move($3), $2);
	}
	| expression OP_DIV expression {
		 $$ = std::make_unique<ExpressionBinaire>(std::move($1), std::move($3), $2);
	}
	| expression OP_EQ expression {
		 $$ = std::make_unique<ExpressionBinaire>(std::move($1), std::move($3), $2);
	}
	| expression OP_GT expression {
		 $$ = std::make_unique<ExpressionBinaire>(std::move($1), std::move($3), $2);
	}
	| expression OP_GE expression {
		 $$ = std::make_unique<ExpressionBinaire>(std::move($1), std::move($3), $2);
	}
	| expression OP_LT expression {
		 $$ = std::make_unique<ExpressionBinaire>(std::move($1), std::move($3), $2);
	}
	| expression OP_LE expression {
		 $$ = std::make_unique<ExpressionBinaire>(std::move($1), std::move($3), $2);
	}
	| expression OP_AND expression {
		 $$ = std::make_unique<ExpressionBinaire>(std::move($1), std::move($3), $2);
	}
	| expression OP_OR expression {
		 $$ = std::make_unique<ExpressionBinaire>(std::move($1), std::move($3), $2);
	}
	| expression '-' expression {
		 $$ = std::make_unique<ExpressionBinaire>(std::move($1), std::move($3), ExpressionBinaire::Operation::SUB);
	}
	/* TODO: Configurer la precedence corretement
	| '-' expression %prec NEG {
		 $$ = std::make_unique<ExpressionUnaire>(std::move($2), ExpressionUnaire::Operation::MIN);
	}
	*/
	| IDENTIFIANT {
		 $$ = std::make_unique<Variable>(driver.contexteCourant->at($1));
	}
	| NOMBRE {
		 $$ = std::make_unique<Constante>(std::make_shared<ElementPrimitif<double>>($1));
	}

forme:
	CARRE expression expression expression {
		$$ = std::make_shared<Carre>($2->eval()->toDouble(), $3->eval()->toDouble(), $4->eval()->toDouble());
	}
	| RECTANGLE expression expression expression expression expression expression expression expression {
		$$ = std::make_shared<Rectangle>($2->eval()->toDouble(), $3->eval()->toDouble(), $4->eval()->toDouble(),
						 $5->eval()->toDouble(), $6->eval()->toDouble(), $7->eval()->toDouble(),
						 $8->eval()->toDouble(), $9->eval()->toDouble());
	}
	| TRIANGLE expression expression expression expression {
		$$ = std::make_shared<Triangle>($2->eval()->toDouble(), $3->eval()->toDouble(), $4->eval()->toDouble(), $5->eval()->toDouble());
	}
	| CERCLE expression expression expression {
		$$ = std::make_shared<Cercle>($2->eval()->toDouble(), $3->eval()->toDouble(), $4->eval()->toDouble());
	}
	| ELLIPSE expression expression expression expression {
		$$ = std::make_shared<Ellipse>($2->eval()->toDouble(), $3->eval()->toDouble(), $4->eval()->toDouble(), $5->eval()->toDouble());
	}
	| LIGNE expression expression expression expression {
		$$ = std::make_shared<Ligne>($2->eval()->toDouble(), $3->eval()->toDouble(), $4->eval()->toDouble(), $5->eval()->toDouble());
	}
	| CHEMIN chemin_points {
		$$ = std::move($2);
	}
	| TEXTE expression expression STRING STRING {
		// TODO: Utiliser des expressions pour texte + nom de police
		$$ = std::make_shared<Texte>($2->eval()->toDouble(), $3->eval()->toDouble(), $4, $5);
	}

chemin_points:
	chemin_points ',' expression expression  {
		$$ = std::move($1);
		$$->ajoutePoint($3->eval()->toDouble(), $4->eval()->toDouble());
	}
	| expression expression {
		$$ = std::make_unique<Chemin>($1->eval()->toDouble(), $2->eval()->toDouble());
	}

proplist_esp:
	KW_COULEUR ':' couleur {
		$$.couleur = *$3;
	}
	| KW_REMPLISSAGE ':' couleur {
		$$.remplissage = *$3;
	}
	| KW_OPACITE ':' expression '%' {
		$$.opacite = $3->eval()->toDouble() * .01f;
	}
	| KW_ROTATION ':' expression DEGREE {
		$$.rotation = fmod($3->eval()->toDouble(), 360.0f);
	}
	| KW_EPAISSEUR ':' expression {
		$$.epaisseur = $3->eval()->toDouble();
	}
	| KW_COULEUR ':' couleur '&' proplist_esp {
		$$.couleur = *$3;
	}
	| KW_REMPLISSAGE ':' couleur '&' proplist_esp {
		$$.remplissage = *$3;
	}
	| KW_OPACITE ':' expression '%' '&' proplist_esp {
		$$.opacite = $3->eval()->toDouble() * .01f;
	}
	| KW_ROTATION ':' expression DEGREE '&' proplist_esp{
		$$.rotation = fmod($3->eval()->toDouble(), 360.0f);
	}
	| KW_EPAISSEUR ':' expression '&' proplist_esp {
		$$.epaisseur = $3->eval()->toDouble();
	}

proplist_nl:
	KW_COULEUR ':' couleur ';' NL {
		$$.couleur = *$3;
	}
	| KW_REMPLISSAGE ':' couleur ';' NL {
		$$.remplissage = *$3;
	}
	| KW_OPACITE ':' expression '%' ';' NL {
		$$.opacite = $3->eval()->toDouble() * .01f;
	}
	| KW_ROTATION ':' expression DEGREE ';' NL {
		$$.rotation = fmod($3->eval()->toDouble(), 360.0f);
	}
	| KW_EPAISSEUR ':' expression ';' NL {
		$$.epaisseur = $3->eval()->toDouble();
	}
	| KW_COULEUR ':' couleur ';' NL proplist_nl {
		$$.couleur = *$3;
	}
	| KW_REMPLISSAGE ':' couleur ';' NL proplist_nl {
		$$.remplissage = *$3;
	}
	| KW_OPACITE ':' expression '%' ';' NL proplist_nl {
		$$.opacite = $3->eval()->toDouble() * .01f;
	}
	| KW_ROTATION ':' expression DEGREE ';' NL proplist_nl {
		$$.rotation = fmod($3->eval()->toDouble(), 360.0f);
	}
	| KW_EPAISSEUR ':' expression ';' NL proplist_nl {
		$$.epaisseur = $3->eval()->toDouble();
	}

couleur:
	 COULEUR_NOM {
		$$ = std::make_unique<Couleur>($1);
	 }
	 | COULEUR_RGB_START expression ',' expression ',' expression ')' {
	 	$$ = std::make_unique<Couleur>($2->eval()->toDouble(), $4->eval()->toDouble(), $6->eval()->toDouble());
	 }
	 | COULEUR_HEX {
	 	$$ = std::make_unique<Couleur>($1);
	 }

affectation:
	IDENTIFIANT OP_EQ expression {
		$$ = std::make_unique<Affectation>(driver.contexteCourant, $1, $3->eval());
	}




appelFonction:
/*
	IDENTIFIANT '(' ')' {
		$$ = std::make_unique<AppelFonction>(driver.contexteCourant);
	}
	IDENTIFIANT '(' arglist ')' {
		$$ = std::make_unique<AppelFonction>(driver.contexteCourant, $3);
	}
*/

arglist:
/*
	expression {
		$$ = std::vector<std::shared_ptr<Expression>>(1, std::move($1));
	}
	| arglist ',' expression {
		$$ = std::move($1);
		$$.push_back(std::move($3));
	}
*/

boucle:
	KW_TANTQUE '(' comparaison ')' corps {
		$$ = std::make_unique<Boucle>(driver.contexteCourant, std::move($3), $5);
	}

branchement:
	KW_SI '(' comparaison ')' corps {
		$$ = std::make_unique<Branchement>(driver.contexteCourant, std::move($3), $5);
	}

corps:
comparaison:

%%

void yy::Parser::error( const location_type &l, const std::string & err_msg) {
	std::cerr << "Erreur : " << l << ", " << err_msg << std::endl;
}
