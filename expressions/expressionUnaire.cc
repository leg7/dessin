#include "expressionUnaire.hh"

ExpressionUnaire::ExpressionUnaire(ExpressionPtr exp, OperateurUnaire op):
    _exp(exp), _op(op) {

}

Expression::Valeur ExpressionUnaire::calculer(const Contexte& contexte) const {
    Expression::Valeur exp = _exp->calculer(contexte);
    switch (_op) {
        case OperateurUnaire::neg: return Expression::Valeur(-exp.nombre());
        default: return 0;
    }
}
