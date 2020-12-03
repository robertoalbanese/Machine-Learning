function varargout = printtable(body, varargin)
% Print character table in custom format.
%
% Syntax
%   printtable(body)
%   printtable(body, Name, Value)
%   charTable = printtable(__)
%
% Description
%   printtable(body) concatenates horizontally and vertically the texts in 
%   body with suitable spaces and delimiters, then prints it in a table
%   format.
%
%   printtable(body, Name, Value) also considers optional comma-separated
%   pairs of Name,Value arguments. For example, you can specify column and
%   row variable names, aligment, spaces, corner and border delimiters.
%
%   charTable = printtable(__) saves result as a character array.
%
% Input arguments
%   body                - Body of table, each column and row must
%                         represent a variable.
%                         Data type: cell array of character vectors
%                         Size     : N-by-M
%
% Name-value pair arguments
%   colVarNames         - Variable name for each column, by default {}.
%                         Data type: cell array of character vectors
%                         Size     : 1-by-M
%   rowVarNames         - Variable name for each row, by default {}.
%                         Data type: cell array of character vectors
%                         Size     : 1-by-N
%   cornerName          - Corner header, by default ''.
%                         Data type: character vector
%                         Size     : 1-by-S
%   alignment           - Aligment of strings.
%                         Data type: character vector
%                         Options  : 'center', 'c' (default)
%                                    'right', 'r'
%                                    'left', 'l'
%   nRightPaddingSpaces - Right padding space of each string, by default 1.
%                         Data type: non-negative integer scalar  
%   nLeftPaddingSpaces  - Left padding space of each string, by default 1.
%                         Data type: non-negative integer scalar 
%   nLeftMarginSpaces   - Left margin space of the table, by default 0. 
%                         Data type: non-negative integer scalar  
%   colHeaderVertDelim  - Column header vertical delimiter, by default '|'.
%                         Data type: character scalar
%   colHeaderHorzDelim  - Column header horizontal delimiter, by default '-'.
%                         Data type: character scalar
%   rowHeaderVertDelim  - Row header vertical delimiter, by default '|'.
%                         Data type: character scalar
%   rowHeaderHorzDelim  - Row header horizontal delimiter, by default ''.
%                         Data type: character scalar
%   bodyVertDelim       - Body vertical delimiter, by default '|'.
%                         Data type: character scalar
%   bodyHorzDelim       - Body horizontal delimiter, by default ''.
%                         Data type: character scalar
%   cornerDelim         - Corners delimiters, by default '+'.
%                         Data type: character scalar
%   topBorderDelim      - Top border delimiter, by default '-'.
%                         Data type: character scalar
%   rightBorderDelim    - Rigth border delimiter, by default '|'.
%                         Data type: character scalar   
%   bottomBorderDelim   - Bottom border delimiter, by default '-'.
%                         Data type: character scalar
%   leftBorderDelim     - Left border delimiter, by default '|'.
%                         Data type: character scalar
%
% Output arguments
%   charTable          - Character table.
%                        Data type: character array.
%                        Size     : P-by-Q          
%
% Notes
%   This function is useful to display values in the command window as a
%   report with functions sprintf, fprintf, warning, error or MException.
%
% Examples
%   Example1: print data in diferent styles.
%   numbers = {'123', '23', '345', '451', '5123'};
%   vowels = {'aei', 'ei', 'iouae', 'oua', 'uae'};
%   consonants = {'bc', 'cdf', 'dfgb', 'f', 'gbcf'};
%   body = [numbers', vowels', consonants'];
%   colVarNames = {'number', 'vowel', 'consonant'};
%   rowVarNames = {'1', '2', '3', '4', '5'};
% 
%   printtable(body,...
%              'colVarNames', colNames',...
%              'rowVarNames', rowNames,...
%              'cornerName', 'No');
%   printtable(body,...
%              'colVarNames', colNames,...
%              'rowVarNames', rowNames,...
%              'cornerName', 'No',...
%              'colHeaderHorzDelim', '~',...
%              'topBorderDelim', '~',...
%              'cornerDelim', 'o');
%   printtable(body,...
%              'colVarNames', colNames,...
%              'rowVarNames', rowNames,...
%              'cornerName', 'Nº',...
%              'colHeaderHorzDelim', '=',...
%              'topBorderDelim', '=',...
%              'cornerDelim', '*',...
%              'rowHeaderHorzDelim', '-',...
%              'bodyHorzDelim', '-');
%
% See also
%   sprintf fprintf interleave

% Copyright 2017 Brayan Torres Zagastizabal 
% brayantz_13@hotmail.com
%
% Revision history
%   2017-09-24: released and uploaded to file exchange (cellstr2CharTable). 
%   2017-12-15: changed name (printTable), changed parameter names,
%               refactorized, added input parser scheme, dependence with
%               the function interleave (FEX).
%   2018-03-21: Changed function name (printtable), changed parameter names,
%               refactorized.



% Parse and check input arguments (classes and attributes).
persistent P
if isempty(P)
    P = inputParser;
    requiredInputs = {'body'};
    optionalInputs = {'colVarNames', {};...
                      'rowVarNames', {};...
                      'cornerName', '';...
                      'alignment', 'center';...
                      'nRightPaddingSpaces', 1;...
                      'nLeftPaddingSpaces', 1;...
                      'nLeftMarginSpaces', 0;...
                      'colHeaderVertDelim', '|';...
                      'colHeaderHorzDelim', '-';...
                      'rowHeaderVertDelim', '|';...
                      'rowHeaderHorzDelim', '';...
                      'bodyVertDelim', '|';...
                      'bodyHorzDelim', '';...
                      'cornerDelim', '+';...
                      'topBorderDelim', '-';...
                      'rightBorderDelim', '|';...
                      'bottomBorderDelim', '-';...
                      'leftBorderDelim', '|'};
                     
    requiredInfo = {{'cell'}, {'nonempty', '2d'}};                
    optionalInfo = {{'cell'}, {'vector'};...
                    {'cell'}, {'vector'};...
                    {'char'}, {'vector'};...
                    {'char'}, {'vector'};...
                    {'numeric'}, {'scalar', 'integer', 'nonnegative'};...
                    {'numeric'}, {'scalar', 'integer', 'nonnegative'};...
                    {'numeric'}, {'scalar', 'integer', 'nonnegative'};...
                    {'char'}, {'scalar'};...
                    {'char'}, {'scalar'};...
                    {'char'}, {'scalar'};...
                    {'char'}, {'scalar'};...
                    {'char'}, {'scalar'};...
                    {'char'}, {'scalar'};...
                    {'char'}, {'scalar'};...
                    {'char'}, {'scalar'};...
                    {'char'}, {'scalar'};...
                    {'char'}, {'scalar'};...
                    {'char'}, {'scalar'}};
   
    validateFunc = @(class, attrib)...
                    (@(x) validateattributes(x, class, attrib));
                
    addRequired(P, requiredInputs{:},...
                validateFunc(requiredInfo{1}, requiredInfo{2}));

    for j = 1:length(optionalInputs)
        addParameter(P, optionalInputs{j,1}, optionalInputs{j,2},...
                     validateFunc(optionalInfo{j,1}, optionalInfo{j,2}));
    end
end
parse(P, body, varargin{:});
Parameter = P.Results;


% Add headers to body to have an unique cell array, content.
[VarNames, alignment, NSpaces, Delim] = groupparameters(Parameter);
content = addheaders(body, VarNames);


% Create elements of table.
contentLengths = cellfun(@(x) length(x), content);
maxSpaces = max(contentLengths, [], 1);

sz = size(body);
colWidths = maxSpaces + NSpaces.nRightPadding + NSpaces.nLeftPadding;
fillingLengths = repmat(maxSpaces, sz(1) + 1, 1) - contentLengths;

Element.Spaces = allocatespaces(alignment, NSpaces, fillingLengths);
Element.Delims = allocatedelims(Delim.Header, Delim.Body, sz, colWidths);
Element.corners = allocatecorners(Delim.corner, sz);
Element.Borders = allocateborders(Delim.Border, Element.corners, sz(1),...
                                  colWidths);

IsEmpty = checkempty(content, Element.Delims, VarNames, Delim.Border);


% Create and save (print) table.
charTable = createtable(content, Element, IsEmpty);                       
if nargout == 0
    fprintf(1, [charTable '\n']);
else
    varargout{1} = sprintf(charTable);
end

end


%% Add headers of table.
function content = addheaders(body, VarNames)

[nRows, nCols] = size(body);
colNames = checksznames(VarNames.col, [1, nCols]);
rowNames = checksznames(VarNames.row, [nRows, 1]);

content = [[cellstr(VarNames.corner); rowNames], [colNames; body]];


%%
    function names = checksznames(names, sz)
    
    if isempty(names)
        names = repmat({''}, sz);
        
    elseif prod(sz) == numel(names)
        names =  reshape(names, sz);
    else
        vectors = {'row', 'column'};
        error([mfilename ':names:IncorretNumberOfNames'],...
              ['The argument ''%s'' must contain one name for each %s '...
               'in the table body.'], iputname(1), vectors{sz > 1})
    end
                
    end

end


%% Allocate empty spaces.
function Spaces = allocatespaces(alignment, NSpaces, fillingLengths)

switch alignment
    case {'center', 'c'}
        nRightSpaces = floor(fillingLengths./2);
        nLeftSpaces = (fillingLengths - nRightSpaces);
        nRightSpaces = nRightSpaces + NSpaces.nRightPadding;
        nLeftSpaces = nLeftSpaces + NSpaces.nLeftPadding;
    case {'right', 'r'}
        nRightSpaces = zeros(size(fillingLengths)) + NSpaces.nRightPadding;
        nLeftSpaces = fillingLengths + NSpaces.nLeftPadding;
    case {'left', 'l'}
        nRightSpaces = fillingLengths + NSpaces.nRightPadding;
        nLeftSpaces = zeros(size(fillingLengths)) + NSpaces.nLeftPadding;
    otherwise
        error([mfilename ':alignment:unknownValue'],...
              'Unknow alignment value.')
end

Spaces.right = repeatchar(nRightSpaces, ' ');
Spaces.left = repeatchar(nLeftSpaces, ' ');
Spaces.margin = ['\n' blanks(NSpaces.nLeftMargin)]; % Scape-spaces sample.

end


%% Allocate vertical and horizontal delimiters.
function Delims = allocatedelims(HeaderDelim, BodyDelim, sz, colWidths)

emptyArray = repmat({''}, sz + 1);

vertDelims = emptyArray;
vertDelims(1, 1:end-1) = repmat(cellstr(HeaderDelim.col.vert), 1, sz(2));
vertDelims(2:end, 1) = repmat(cellstr(HeaderDelim.row.vert), sz(1), 1);
vertDelims(2:end, 2:end-1) = repmat(cellstr(BodyDelim.vert), sz(1), sz(2)-1);
Delims.vert = vertDelims;

horzDelims = emptyArray;
widths = repmat(colWidths, sz(1), 1);
horzDelims(1,:) = repeatchar(widths(1,:), HeaderDelim.col.horz);
horzDelims(2:end-1, 1) = repeatchar(widths(2:end, 1), HeaderDelim.row.horz);
horzDelims(2:end-1, 2:end) = repeatchar(widths(2:end, 2:end), BodyDelim.horz);
Delims.horz = horzDelims;

end


%% Allocate corners.
function corners = allocatecorners(cornerDelim, sz)

corners = repmat({''}, sz + 1);
corners(1:end-1, 1:end-1) = repmat(cellstr(cornerDelim), sz);

end


%% Allocate borders.
function Borders = allocateborders(DelimBorder, corners, tableHeight,...
                                   colWidths)

topBorder = repeatchar(colWidths, DelimBorder.top);
Borders.top = interleave(2, topBorder, corners(1,:));

bottomBorder = repeatchar(colWidths, DelimBorder.bottom);
Borders.bottom = interleave(2, bottomBorder, corners(1,:));

rightBorder = repmat(cellstr(DelimBorder.right), tableHeight(1) + 1, 1);
Borders.right = [corners(1);...
                 interleave(1, rightBorder, corners(:,1));...
                 corners(1)];

leftBorder = repmat(cellstr(DelimBorder.left), tableHeight(1) + 1, 1);
Borders.left = [corners(1);...
                interleave(1, leftBorder, corners(:,1));...
                corners(1)];

end


%% Check empty rows and columns.
function IsEmpty = checkempty(content, Delims, VarNames, DelimBorder)

isEmptyContent = cellfun('isempty', content);
              
hasRowContent = all(isEmptyContent, 2);
hasHorzDelim = all(cellfun('isempty', Delims.horz), 2);
hasHorzDelim(1) = isempty(VarNames.col) && isempty(VarNames.corner);

IsEmpty.row = [isempty(DelimBorder.top);...
               interleave(1, hasRowContent, hasHorzDelim);...
               isempty(DelimBorder.bottom)];

hasColContent = all(isEmptyContent, 1);
hasVertDelim = all(cellfun('isempty', Delims.vert), 1);
hasVertDelim(1) = isempty(VarNames.row) && isempty(VarNames.corner);

IsEmpty.col = [isempty(DelimBorder.right),...
               interleave(2, hasColContent, hasVertDelim),...
               isempty(DelimBorder.left)];

end


%% Create character table.
function charTable = createtable(content, Element, IsEmpty)

% Add elements to table.
strTable = strcat(Element.Spaces.right, content, Element.Spaces.left);
strTable = interleave(2, strTable, Element.Delims.vert);
horzStrings = interleave(2, Element.Delims.horz, Element.corners);
strTable = interleave(1, strTable, horzStrings);

strTable = vertcat(Element.Borders.top, strTable, Element.Borders.bottom);
strTable = horzcat(Element.Borders.right, strTable, Element.Borders.left);

strTable = strTable(~IsEmpty.row,:);
strTable = strTable(:,~IsEmpty.col);


% Convert to char table and add left margin spaces.
nRows = size(strTable, 1);
charTable = arrayfun(@(x) [strTable{x,:}], 1:nRows, 'UniformOutput', false);
charTable = vertcat(charTable{:});

marginSpaces = repmat(Element.Spaces.margin, nRows, 1);
charTable = reshape([marginSpaces, charTable].', 1, []);

end


%% 
function [VarNames, alignment, NSpaces, Delim] = groupparameters(Parameter)

VarNames.col = Parameter.colVarNames;
VarNames.row = Parameter.rowVarNames;
VarNames.corner = Parameter.cornerName;

alignment = Parameter.alignment;

NSpaces.nRightPadding = Parameter.nRightPaddingSpaces;
NSpaces.nLeftPadding = Parameter.nLeftPaddingSpaces;
NSpaces.nLeftMargin = Parameter.nLeftMarginSpaces;

Delim.Header.col.vert = Parameter.colHeaderVertDelim;
Delim.Header.col.horz = Parameter.colHeaderHorzDelim;
Delim.Header.row.vert = Parameter.rowHeaderVertDelim;
Delim.Header.row.horz = Parameter.rowHeaderHorzDelim;

Delim.Body.vert = Parameter.bodyVertDelim;
Delim.Body.horz = Parameter.bodyHorzDelim;

Delim.corner = Parameter.cornerDelim;

Delim.Border.top = Parameter.topBorderDelim;
Delim.Border.right = Parameter.rightBorderDelim;
Delim.Border.bottom = Parameter.bottomBorderDelim;
Delim.Border.left = Parameter.leftBorderDelim;

end


%%
function b = repeatchar(a, str)

b = cell(size(a));
for i = 1:numel(a)
    b{i} = repmat(str, 1, a(i));
end

end
