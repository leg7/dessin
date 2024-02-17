#include "Contexte.h"

bool Contexte::add(const std::string &nom, const std::shared_ptr<Element> &e) noexcept
{
	const auto ret = _data.insert({nom, e});
	return ret.second;
}

bool Contexte::rm(const std::string &nom) noexcept
{
	return _data.erase(nom);
}
