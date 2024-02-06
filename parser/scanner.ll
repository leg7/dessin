%{

#include "scanner.hh"
#include <cstdlib>

#define YY_NO_UNISTD_H

using token = yy::Parser::token;

#undef	YY_DECL
#define YY_DECL int Scanner::yylex( yy::Parser::semantic_type * const lval, yy::Parser::location_type *loc )

/* update location on matching */
#define YY_USER_ACTION loc->step(); loc->columns(yyleng);

%}

NUMBER [0-9]+
HEX "#"[0-9A-Fa-f]{6}

%option c++
%option yyclass="Scanner"
%option noyywrap

%%
%{
	yylval = lval;
%}
fin return token::END;


"+"				 return '+';
"*"				 return '*';
"-"				 return '-';
"/"				 return '/';
"("				 return '(';
")"				 return ')';
"="				 return '=';

(?i:carre)		         return token::CARRE;
(?i:rectangle)	                 return token::RECTANGLE;
(?i:triangle)	                 return token::TRIANGLE;
(?i:cercle)		         return token::CERCLE;
(?i:ellipse)	                 return token::ELLIPSE;
(?i:ligne)		         return token::LIGNE;
(?i:chemin)		         return token::CHEMIN;
(?i:texte)		         return token::TEXTE;
","				 return ',';

":"				 return ':';
"&"				 return '&';
";"				 return ';';
"->"			         return token::FLECHE;
"{"				 return '{';
"}"				 return '}';


"couleur" return token::COULEUR;
"rgb("	  return token::COULEUR_RGB;
{HEX} {
	std::cout << "match";
	yylval->build<unsigned>(std::strtoul(YYText()+1, nullptr, 16));
	return token::COULEUR_HEX;
}

[A-Za-z_][A-Za-z_0-9]* {
    yylval->build<const char*>(YYText());
    return token::IDENTIFIANT;
}

"rouge" {
	yylval->build<Couleur::Nom>(Couleur::Nom::Rouge);
	return token::COULEUR_NOM;
}
"vert" {
	yylval->build<Couleur::Nom>(Couleur::Nom::Vert);
	return token::COULEUR_NOM;
}
"bleu" {
	yylval->build<Couleur::Nom>(Couleur::Nom::Bleu);
	return token::COULEUR_NOM;
}
"jaune" {
	yylval->build<Couleur::Nom>(Couleur::Nom::Jaune);
	return token::COULEUR_NOM;
}
"orange" {
	yylval->build<Couleur::Nom>(Couleur::Nom::Orange);
	return token::COULEUR_NOM;
}
"violet" { yylval->build<Couleur::Nom>(Couleur::Nom::Violet);
	return token::COULEUR_NOM;
}
"magenta" { yylval->build<Couleur::Nom>(Couleur::Nom::Magenta);
	return token::COULEUR_NOM;
}
"cyan" { yylval->build<Couleur::Nom>(Couleur::Nom::Cyan);
	return token::COULEUR_NOM;
}
"blanc" {
	yylval->build<Couleur::Nom>(Couleur::Nom::Blanc);
	return token::COULEUR_NOM;
}
"noir" {
	yylval->build<Couleur::Nom>(Couleur::Nom::Noir);
	return token::COULEUR_NOM;
}

"\"[[:alpha:]]\"" {
	yylval->build<const char*>(YYText());
	return token::STRING;
}

{NUMBER} {
	yylval->build<int>(std::atoi(YYText()));
	return token::NUMBER;
}

"\n" {
	loc->lines();
	return token::NL;
}

%%
