CREATE TABLE choices
(
    "ID"	INT,
    ChoiceA	VARCHAR(512),
    ChoiceB	VARCHAR(512),
    ChoiceC	VARCHAR(512),
    ChoiceD	VARCHAR(512),
    QuestionID	INT
);
go
INSERT INTO choices ("ID", ChoiceA, ChoiceB, ChoiceC, ChoiceD, QuestionID) VALUES
	('1', ' HTML describes the structure of a webpage', 'HTML is the standard markup language mainly used to create web pages', 'HTML consists of a set of elements that helps the browser how to view the content', 'All of the mentioned', '1'),
	('2', 'Rasmus Lerdorf', 'Tim Berners-Lee', 'Brendan Eich', 'Sergey Brin', '2'),
	('3', ' HyperText Markup Language', 'HyperText Machine Language', 'HyperText Marking Language', 'HighText Marking Language', '3'),
	('4', '</doctype html>', '<doctype html>', '<doctype html!>', '<!doctype html>', '4'),
	('5', 'Web server', 'Web network', 'Web browser', 'Web matrix', '5'),
	('6', ' head', '<h1>', '<h6>', 'heading', '6'),
	('7', 'Language dependent application programming', 'Hierarchy of objects in ASP.NET', 'Application programming interface', 'Convention for representing and interacting with objects in html documents', '7'),
	('8', 'head tag', 'title tag', 'html tag', 'body tag', '8'),
	('9', '<u>', '<mark>', '<highlight>', '<b>', '9'),
	('10', '<track>', ' <video>', '<slider>', '<source>', '10'),
	('21', '?<css>', '<!DOCTYPE html>', '<script>', '<style>', '21'),
	('22', 'tag', 'id', 'class', 'both class and tag', '22'),
	('23', 'HTML', 'PHP', 'CSS', 'Ajax', '23'),
	('24', 'django', 'rails', 'larawell', 'bootstrap', '24'),
	('25', 'tag', 'id', 'class', 'both class and tag', '25'),
	('26', '?<script>', '<link>', '<class>', '<style>', '26'),
	('27', '?text-decoration', 'font-weight', 'font-style', 'text-align', '27'),
	('28', 'style', 'font', 'font-style', '@font-face', '28'),
	('29', 'chrome', 'web', '-o-', 'webkit', '29'),
	('30', 'font-size', '?text-size', 'text', 'size', '30'),
	('41', 'Object-Oriented', '1. Object-Based', 'Assembly-language', '1. High-level', '41'),
	('42', '1. Alternative to if-else', '1. Switch statement', '1. If-then-else statement', '1. immediate if', '42'),
	('43', '1. Shows a warning', '1. Prompts to complete the statement', '1. Throws an error', '1. Ignores the statements', '43'),
	('44', '1. Keywords', '1. Data types', '1. Declaration statements', '1. Prototypes', '44'),
	('45', '1. Global variable', 'local element', '1. The two of the above', 'None', '45'),
	('46', '1. Preprocessor', '1. Triggering Event', '1. RMI', '1. Function/Method', '46'),
	('47', '1. Mutable variable', '1. Dynamic variable', '1. Volatile variable', '1. Immutable variable', '47'),
	('48', '1. 00', '1. 0x', '1. 0X', '1. Both 0x and 0X', '48'),
	('49', '1. Syntax error', '1. Missing of semicolons', '1. Division by zero', '1. Missing of Bracket', '49'),
	('50', '1. Alternative to if-else', '1. Switch statement', '1. If-then-else statement', '1. immediate if', '50');