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
	#include "../expressions/Propriete.h"

	#include "../instructions/Instruction.h"
	#include "../instructions/AffectationExpression.h"
	#include "../instructions/AffectationPropriete.h"
	#include "../instructions/Boucle.h"
	#include "../instructions/Branchement.h"
	#include "../instructions/Declaration.h"
	#include "../instructions/AppelFonction.h"

	#include "../elements/Taille.h"
	#include "../elements/Couleur.h"
	#include "../elements/ElementSimple.h"
	#include "../elements/formes/Forme.h"
	#include "../elements/formes/Carre.h"
	#include "../elements/formes/Cercle.h"
	#include "../elements/formes/Chemin.h"
	#include "../elements/formes/Ellipse.h"
	#include "../elements/formes/Ligne.h"
	#include "../elements/formes/Rectangle.h"
	#include "../elements/formes/Texte.h"
	#include "../elements/formes/Triangle.h"
	#include "../elements/Fonction.h"

	class Scanner;
	class Driver;
	#define YYDEBUG 1
}

%define parse.trace
%parse-param { Scanner &scanner }
%parse-param { Driver &driver }

%code{
	#include "Driver.h"
	#include "scanner.hh"

	#undef	yylex
	#define yylex scanner.yylex
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
%token KW_POSX
%token KW_POSY
%token KW_POSX1
%token KW_POSY1
%token KW_POSX2
%token KW_POSY2
%token KW_POSX3
%token KW_POSY3
%token KW_POSX4
%token KW_POSY4
%token KW_LARGEUR
%token KW_HAUTEUR
%token KW_FONCTION

%token KW_BOOLEAN
%token KW_ENTIER
%token KW_REEL

%token KW_SI
%token KW_ALORS
%token KW_SINON

%token KW_TANTQUE
%token KW_REPETE
%token KW_FOIS

%token OP_AFF
%token <ExpressionBinaire::Operation> OP_ADD
%token <ExpressionBinaire::Operation> OP_MUL
%token <ExpressionBinaire::Operation> OP_DIV
%token <ExpressionBinaire::Operation> OP_EQ
%token <ExpressionBinaire::Operation> OP_NE
%token <ExpressionBinaire::Operation> OP_GT
%token <ExpressionBinaire::Operation> OP_GE
%token <ExpressionBinaire::Operation> OP_LT
%token <ExpressionBinaire::Operation> OP_LE
%token <ExpressionBinaire::Operation> OP_AND
%token <ExpressionBinaire::Operation> OP_OR
%token <ExpressionUnaire::Operation> OP_NEG

%left OP_EQ OP_NE OP_GT OP_GE OP_LT OP_LE OP_AND OP_OR
%left '-' OP_ADD OP_MUL OP_DIV
%right KW_SI KW_SINON
%precedence NEG

%token KW_CARRE
%token KW_RECTANGLE
%token KW_TRIANGLE
%token KW_CERCLE
%token KW_ELLIPSE
%token KW_LIGNE
%token KW_CHEMIN
%token KW_TEXTE
%token <std::string> STRING

%type <std::unique_ptr<Instruction>> instruction
%type <std::unique_ptr<Expression>> expression

%type <std::unique_ptr<Declaration>> declaration
%type <std::unique_ptr<Forme>> forme
%type <std::unique_ptr<Chemin>> chemin_points
%type <std::unique_ptr<Forme::messageSetPropriete>> proplist_esp
%type <std::unique_ptr<Forme::messageSetPropriete>> proplist_nl
%type <std::unique_ptr<Forme::messageSetPropriete>> propriete
%type <std::unique_ptr<Forme::messageSetPropriete>> propriete_float
%type <std::unique_ptr<Forme::messageSetPropriete>> propriete_couleur

%type <std::unique_ptr<Couleur>> couleur

%type <std::unique_ptr<Affectation>> affectation
%type <std::unique_ptr<Forme::messageSetPropriete>> affectation_propriete
%type <std::unique_ptr<Forme::messageSetPropriete>> affectation_propriete_float
%type <std::unique_ptr<Forme::messageSetPropriete>> affectation_propriete_couleur

%type <std::unique_ptr<Branchement>> branchement
%type <std::vector<std::shared_ptr<Instruction>>> then

%type <std::unique_ptr<Boucle>> boucle

%type <std::vector<std::string>> arglist
%type <std::unique_ptr<AppelFonction>> appel_fonction
%type <std::vector<std::shared_ptr<Expression>>> argvals
%%


programme:
	instruction NL programme
	| NL programme
	| END NL {
		YYACCEPT;
	}

instruction:
	appel_fonction {
		driver.ast.add(std::move($1));
	}
	| branchement {
		driver.ast.add(std::move($1));
	}
	| declaration {
		driver.ast.add(std::move($1));
	}
	| affectation ';' {
		driver.ast.add(std::move($1));
	}
	| boucle {
		driver.ast.add(std::move($1));
	}

expression:
	'(' expression ')' {
		$$ = std::move($2);
	}
	| expression OP_ADD expression {
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
	| IDENTIFIANT '.' KW_COULEUR {
		$$ = std::make_unique<Propriete>(driver.contexteCourant, $1, Forme::Propriete::Couleur);
	}
	| IDENTIFIANT '.' KW_REMPLISSAGE {
		$$ = std::make_unique<Propriete>(driver.contexteCourant, $1, Forme::Propriete::Remplissage);
	}
	| IDENTIFIANT '.' KW_OPACITE {
		$$ = std::make_unique<Propriete>(driver.contexteCourant, $1, Forme::Propriete::Opacite);
	}
	| IDENTIFIANT '.' KW_ROTATION {
		$$ = std::make_unique<Propriete>(driver.contexteCourant, $1, Forme::Propriete::Rotation);
	}
	| IDENTIFIANT '.' KW_EPAISSEUR {
		$$ = std::make_unique<Propriete>(driver.contexteCourant, $1, Forme::Propriete::Epaisseur);
	}
	| IDENTIFIANT '.' KW_POSX {
		$$ = std::make_unique<Propriete>(driver.contexteCourant, $1, Forme::Propriete::Point, 0);
	}
	| IDENTIFIANT '.' KW_POSY {
		$$ = std::make_unique<Propriete>(driver.contexteCourant, $1, Forme::Propriete::Point, 1);
	}
	| IDENTIFIANT '.' KW_POSX1 {
		$$ = std::make_unique<Propriete>(driver.contexteCourant, $1, Forme::Propriete::Point, 0);
	}
	| IDENTIFIANT '.' KW_POSY1 {
		$$ = std::make_unique<Propriete>(driver.contexteCourant, $1, Forme::Propriete::Point, 1);
	}
	| IDENTIFIANT '.' KW_POSX2 {
		$$ = std::make_unique<Propriete>(driver.contexteCourant, $1, Forme::Propriete::Point, 2);
	}
	| IDENTIFIANT '.' KW_POSY2 {
		$$ = std::make_unique<Propriete>(driver.contexteCourant, $1, Forme::Propriete::Point, 3);
	}
	| IDENTIFIANT '.' KW_POSX3 {
		$$ = std::make_unique<Propriete>(driver.contexteCourant, $1, Forme::Propriete::Point, 4);
	}
	| IDENTIFIANT '.' KW_POSY3 {
		$$ = std::make_unique<Propriete>(driver.contexteCourant, $1, Forme::Propriete::Point, 5);
	}
	| IDENTIFIANT '.' KW_POSX4 {
		$$ = std::make_unique<Propriete>(driver.contexteCourant, $1, Forme::Propriete::Point, 6);
	}
	| IDENTIFIANT '.' KW_POSY4 {
		$$ = std::make_unique<Propriete>(driver.contexteCourant, $1, Forme::Propriete::Point, 7);
	}
	| IDENTIFIANT '.' KW_LARGEUR {
		// TODO
		$$ = std::make_unique<Constante>(1);
	}
	| IDENTIFIANT '.' KW_HAUTEUR {
		// TODO
		$$ = std::make_unique<Constante>(1);
	}
	| IDENTIFIANT '.' KW_TAILLE {
		const auto tmp = driver.contexteCourant->at($1);
		if (tmp->type() != Element::Type::Carre) {
			std::cerr << "Seulement les carres ont une taille!\n";
			exit(727);
		}
		$$ = std::make_unique<Propriete>(driver.contexteCourant, $1, Forme::Propriete::Taille);
	}
	| IDENTIFIANT {
		 $$ = std::make_unique<Variable>(driver.contexteCourant, $1);
	}
	| NOMBRE {
		 $$ = std::make_unique<Constante>($1);
	}
	| couleur {
		$$ = std::make_unique<Constante>(std::move($1));
	}

declaration:
	forme ';' {
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::move($1));
	}
	| forme FLECHE proplist_esp ';' {
		$1->recevoirMessage(*$3);
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::move($1));
	}
	| forme '{' NL proplist_nl '}' {
		$1->recevoirMessage(*$4);
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::move($1));
	}
	| IDENTIFIANT OP_AFF forme ';' {
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::move($3), $1);
	}
	| IDENTIFIANT OP_AFF forme FLECHE proplist_esp ';' {
		$3->recevoirMessage(*$5);
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::move($3), $1);
	}
	| IDENTIFIANT OP_AFF forme '{' NL proplist_nl '}' {
		$3->recevoirMessage(*$6);
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::move($3), $1);
	}
	| KW_COULEUR IDENTIFIANT OP_AFF couleur ';' {
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::move($4), $2);
	}
	| KW_BOOLEAN IDENTIFIANT OP_AFF expression ';' {
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::make_shared<ElementSimple>(std::move($4)), $2);
	}
	| KW_ENTIER IDENTIFIANT OP_AFF expression ';' {
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::make_shared<ElementSimple>(std::move($4)), $2);
	}
	| KW_REEL IDENTIFIANT OP_AFF expression ';' {
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::make_shared<ElementSimple>(std::move($4)), $2);
	}
	| KW_TAILLE expression expression ';' {
		/* TODO
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::make_shared<Taille>(std::move($2), std::move($3)), "taille");
		*/
	}
	| KW_FONCTION IDENTIFIANT '(' arglist ')' '{' NL then '}' {
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::make_shared<Fonction>(driver.contexteCourant, std::move($4), $8));
	}

forme:
	KW_CARRE expression expression expression {
		$$ = std::make_unique<Carre>(std::move($2), std::move($3), std::move($4));
	}
	| KW_RECTANGLE expression expression expression expression expression expression expression expression {
		$$ = std::make_unique<Rectangle>(std::move($2), std::move($3), std::move($4), std::move($5), std::move($6), std::move($7), std::move($8), std::move($9));
	}
	| KW_TRIANGLE expression expression expression expression {
		$$ = std::make_unique<Triangle>(std::move($2), std::move($3), std::move($4), std::move($5));
	}
	| KW_CERCLE expression expression expression {
		$$ = std::make_unique<Cercle>(std::move($2), std::move($3), std::move($4));
	}
	| KW_ELLIPSE expression expression expression expression {
		$$ = std::make_unique<Ellipse>(std::move($2), std::move($3), std::move($4), std::move($5));
	}
	| KW_LIGNE expression expression expression expression {
		$$ = std::make_unique<Ligne>(std::move($2), std::move($3), std::move($4), std::move($5));
	}
	| KW_CHEMIN chemin_points {
		$$ = std::move($2);
	}
	| KW_TEXTE expression expression STRING STRING {
		// TODO: Utiliser des expressions pour texte + nom de police
		$$ = std::make_unique<Texte>(std::move($2), std::move($3), $4, $5);
	}

chemin_points:
	chemin_points ',' expression expression  {
		$$ = std::move($1);
		$$->ajoutePoint(std::move($3), std::move($4));
	}
	| expression expression {
		$$ = std::make_unique<Chemin>(std::move($1), std::move($2));
	}

proplist_esp:
	propriete '&' proplist_esp {
		$$ = std::move($1);
	}
	| propriete {
		$$ = std::move($1);
	}

proplist_nl:
	propriete ';' NL proplist_nl {
		$$ = std::move($1);
	}
	| propriete ';' NL {
		$$ = std::move($1);
	}

propriete:
	 propriete_couleur {
	 	$$ = std::move($1);
	 }
	 | propriete_float {
	 	$$ = std::move($1);
	 }

propriete_couleur:
	KW_COULEUR ':' couleur {
		$$ = std::make_unique<Forme::messageSetPropriete>(Forme::Propriete::Couleur, std::make_shared<Constante>(std::move($3)));
	}
	| KW_REMPLISSAGE ':' couleur {
		$$ = std::make_unique<Forme::messageSetPropriete>(Forme::Propriete::Remplissage, std::make_shared<Constante>(std::move($3)));
	}

propriete_float:
	KW_OPACITE ':' expression '%' {
		$$ = std::make_unique<Forme::messageSetPropriete>(Forme::Propriete::Opacite, std::move($3));
	}
	| KW_ROTATION ':' expression DEGREE {
		$$ = std::make_unique<Forme::messageSetPropriete>(Forme::Propriete::Rotation, std::move($3));
	}
	| KW_EPAISSEUR ':' expression {
		$$ = std::make_unique<Forme::messageSetPropriete>(Forme::Propriete::Epaisseur, std::move($3));
	}
	| KW_TAILLE ':' expression {
		$$ = std::make_unique<Forme::messageSetPropriete>(Forme::Propriete::Taille, std::move($3));
	}

couleur:
	 COULEUR_NOM {
		$$ = std::make_unique<Couleur>($1);
	 }
	 | COULEUR_RGB_START expression ',' expression ',' expression ')' {
	 	$$ = std::make_unique<Couleur>(std::move($2), std::move($4), std::move($6));
	 }
	 | COULEUR_HEX {
	 	$$ = std::make_unique<Couleur>($1);
	 }

affectation:
	IDENTIFIANT '.' affectation_propriete {
		$$ = std::make_unique<AffectationPropriete>(driver.contexteCourant, $1, *$3);
	}
	| IDENTIFIANT OP_AFF expression {
		$$ = std::make_unique<AffectationExpression>(driver.contexteCourant, $1, std::move($3));
	}
	| KW_CARRE '[' expression ']' '.' affectation_propriete {
		$$ = std::make_unique<AffectationPropriete>(driver.contexteCourant, "carre", *$6, std::move($3));
	}
	| KW_RECTANGLE '[' expression ']' '.' affectation_propriete {
		$$ = std::make_unique<AffectationPropriete>(driver.contexteCourant, "rectangle", *$6, std::move($3));
	}
	| KW_TRIANGLE '[' expression ']' '.' affectation_propriete {
		$$ = std::make_unique<AffectationPropriete>(driver.contexteCourant, "triangle", *$6, std::move($3));
	}
	| KW_CERCLE '[' expression ']' '.' affectation_propriete {
		$$ = std::make_unique<AffectationPropriete>(driver.contexteCourant, "cercle", *$6, std::move($3));
	}
	| KW_ELLIPSE '[' expression ']' '.' affectation_propriete {
		$$ = std::make_unique<AffectationPropriete>(driver.contexteCourant, "ellipse", *$6, std::move($3));
	}
	| KW_LIGNE '[' expression ']' '.' affectation_propriete {
		$$ = std::make_unique<AffectationPropriete>(driver.contexteCourant, "ligne", *$6, std::move($3));
	}
	| KW_CHEMIN '[' expression ']' '.' affectation_propriete {
		$$ = std::make_unique<AffectationPropriete>(driver.contexteCourant, "chemin", *$6, std::move($3));
	}
	| KW_TEXTE '[' expression ']' '.' affectation_propriete {
		$$ = std::make_unique<AffectationPropriete>(driver.contexteCourant, "texte", *$6, std::move($3));
	}

affectation_propriete:
	affectation_propriete_float {
		$$ = std::move($1);
	}
	| affectation_propriete_couleur {
		$$ = std::move($1);
	}

affectation_propriete_float:
	KW_OPACITE OP_AFF expression '%' {
		$$ = std::make_unique<Forme::messageSetPropriete>(Forme::Propriete::Opacite, std::move($3));
	}
	| KW_ROTATION OP_AFF expression DEGREE {
		$$ = std::make_unique<Forme::messageSetPropriete>(Forme::Propriete::Rotation, std::move($3));
	}
	| KW_EPAISSEUR OP_AFF expression {
		$$ = std::make_unique<Forme::messageSetPropriete>(Forme::Propriete::Epaisseur, std::move($3));
	}
	| KW_POSX OP_AFF expression {
		$$ = std::make_unique<Forme::messageSetPropriete>(Forme::Propriete::Point, std::move($3), 0);
	}
	| KW_POSY OP_AFF expression {
		$$ = std::make_unique<Forme::messageSetPropriete>(Forme::Propriete::Point, std::move($3), 1);
	}
	| KW_POSX1 OP_AFF expression {
		$$ = std::make_unique<Forme::messageSetPropriete>(Forme::Propriete::Point, std::move($3), 0);
	}
	| KW_POSY1 OP_AFF expression {
		$$ = std::make_unique<Forme::messageSetPropriete>(Forme::Propriete::Point, std::move($3), 1);
	}
	| KW_POSX2 OP_AFF expression {
		$$ = std::make_unique<Forme::messageSetPropriete>(Forme::Propriete::Point, std::move($3), 2);
	}
	| KW_POSY2 OP_AFF expression {
		$$ = std::make_unique<Forme::messageSetPropriete>(Forme::Propriete::Point, std::move($3), 3);
	}
	| KW_POSX3 OP_AFF expression {
		$$ = std::make_unique<Forme::messageSetPropriete>(Forme::Propriete::Point, std::move($3), 4);
	}
	| KW_POSY3 OP_AFF expression {
		$$ = std::make_unique<Forme::messageSetPropriete>(Forme::Propriete::Point, std::move($3), 5);
	}
	| KW_POSX4 OP_AFF expression {
		$$ = std::make_unique<Forme::messageSetPropriete>(Forme::Propriete::Point, std::move($3), 6);
	}
	| KW_POSY4 OP_AFF expression {
		$$ = std::make_unique<Forme::messageSetPropriete>(Forme::Propriete::Point, std::move($3), 7);
	}
	| KW_TAILLE OP_AFF expression {
		$$ = std::make_unique<Forme::messageSetPropriete>(Forme::Propriete::Taille, std::move($3));
	}

affectation_propriete_couleur:
	KW_COULEUR OP_AFF couleur {
		$$ = std::make_unique<Forme::messageSetPropriete>(Forme::Propriete::Couleur, std::make_unique<Constante>(std::move($3)));
	}
	| KW_REMPLISSAGE OP_AFF couleur {
		$$ = std::make_unique<Forme::messageSetPropriete>(Forme::Propriete::Remplissage, std::make_unique<Constante>(std::move($3)));
	}

branchement:
	KW_SI expression KW_ALORS '{' NL then '}' NL KW_SINON '{' NL then '}' {
		$$ = std::make_unique<Branchement>(driver.contexteCourant, std::move($2), $6, $12);
	}
	| KW_SI expression KW_ALORS '{' NL then '}' NL {
		$$ = std::make_unique<Branchement>(driver.contexteCourant, std::move($2), $6);
	}

then:
	instruction NL then {
		$$.push_back(std::move($1));
	}
	| instruction NL {
		$$.push_back(std::move($1));
	}

boucle:
	KW_TANTQUE expression '{' NL then '}' {
		$$ = std::make_unique<Boucle>(driver.contexteCourant, std::move($2), $5);
	}
	| KW_REPETE expression KW_FOIS '{' NL then '}' {
		$$ = std::make_unique<Boucle>(driver.contexteCourant, std::move($2), $6, true);
	}

arglist:
	IDENTIFIANT {
		$$.push_back($1);
	}
	| arglist ',' IDENTIFIANT {
		$$.push_back($3);
	}

appel_fonction:
	IDENTIFIANT argvals {
		$$ = std::make_unique<AppelFonction>(driver.contexteCourant, $1, $2);
	}

argvals:
	 expression {
	 	$$.push_back(std::move($1));
	 }
	 | expression argvals {
		$$.push_back(std::move($1));
	 }


%%

void yy::Parser::error(const location_type &l, const std::string & err_msg) {
	std::cerr << "Erreur : " << l << ", " << err_msg << std::endl;
}
